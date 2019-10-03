ZRM = {}
local KeyBindings = PowerCommuter.KeyBindings
local Teleport = PowerCommuter.Teleport
local LuaUtils = PowerCommuter.LuaUtils
local Bindings = nil

local keyboardMenu
local gamepadMenu
local isInteracting = false
local sceneName = "pw_radial_menu"
local scene = ZO_Scene:New(sceneName, SCENE_MANAGER)

scene:AddFragment(GAMEPAD_UI_MODE_FRAGMENT)
scene:AddFragment(UI_SHORTCUTS_ACTION_LAYER_FRAGMENT)



local function CreateRadialMenu(control, template)
    local result = ZO_RadialMenu:New(control, template, "DefaultRadialMenuAnimation", "DefaultRadialMenuEntryAnimation", "RadialMenu")
    result.selectIfCentered = false
    result:SetOnClearCallback(function() ZRM.StopInteraction() end)
    return result
end

local function GetKeyboardMenu()
    if not keyboardMenu then
        keyboardMenu = CreateRadialMenu(ZoneRadialMenu_Keyboard, "ZO_PlayerToPlayerMenuEntryTemplate_Keyboard")
    end
    return keyboardMenu
    
end

local function GetGamepadMenu()
    if not gamepadMenu then
        gamepadMenu = CreateRadialMenu(ZoneRadialMenu_Gamepad, "ZO_RadialMenuHUDEntryTemplate_Gamepad")
    end
    return gamepadMenu
end

local function GetRadialMenu()
    if IsInGamepadPreferredMode() then
        return GetGamepadMenu()
    else
        return GetKeyboardMenu()
    end
end

local function RemapIndex(index)
    index = 9 - index - 4
    if index < 1 then
        index = index + 8
    end
    return index
end

local function PopulateEntries(menu)
    local emptyIcon = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds"
    local zoneIcon = "EsoUI/Art/Journal/journal_tabIcon_quest_up.dds"

    local menu = GetRadialMenu()
    local possibleJumpTargets = Teleport.GetAllPossibleJumpTargets()

    -- Get late reference to bindings
    if not Bindings then
        Bindings = PowerCommuter.UserSettings.KeyBindings
    end

    for i = 1, KeyBindings.BINDINGS_COUNT do

        local mappedIndex = RemapIndex(i)
        local text = "Not Set"
        local icon = emptyIcon
        
        if Bindings[mappedIndex] then
            local zoneName = GetZoneNameById(Bindings[mappedIndex])
            local playerCount = LuaUtils.Count(possibleJumpTargets, function(playerInfo)
                return playerInfo.characterInfo.zoneName == zoneName
            end)
            text = string.format("%s (%s)", zoneName, playerCount)
            icon = zoneIcon
        end

        local jumpFunc = function()
            KeyBindings.JumpKeybindDown(mappedIndex)
        end
        menu:AddEntry(text, icon, icon, jumpFunc, nil)
        menu.entries[i].index = mappedIndex
    end
end

local keystripButtons = 
{
    {
        name = "Assign Location",
        keybind = "UI_SHORTCUT_LEFT_SHOULDER",
        callback = function() 
            local menu = GetRadialMenu()
            if menu.selectedEntry then
                local index = menu.selectedEntry.index
                KeyBindings.SetKeybindingToCurrentZone(index)
                df("Jump to Zone %d set to: %s", index, GetZoneNameById(PowerCommuter.UserSettings.KeyBindings[index]))
                menu.selectedEntry = nil
                ZRM.StopInteraction()
            end
        end
    },
    {
        name = "Clear Location",
        keybind = "UI_SHORTCUT_RIGHT_SHOULDER",
        callback = function() 
            local menu = GetRadialMenu()
            if menu.selectedEntry then
                local index = menu.selectedEntry.index
                KeyBindings.ClearKeybinding(index)
                df("Jump to Zone %d cleared", index)
                menu.selectedEntry = nil
                ZRM.StopInteraction()
            end
        end
    },
    alignment = KEYBIND_STRIP_ALIGN_CENTER
}

function ZRM.StartInteraction()

    scene:AddFragmentGroup(FRAGMENT_GROUP.GAMEPAD_KEYBIND_STRIP_GROUP)
    SCENE_MANAGER:Show(sceneName)

    KEYBIND_STRIP:AddKeybindButtonGroup(keystripButtons)

    local menu = GetRadialMenu();
    PopulateEntries(menu)
    menu:Show()

    

    LockCameraRotation(true)
    RETICLE:RequestHidden(true)    
    isInteracting = true
end

function ZRM.StopInteraction()
    if isInteracting then

        KEYBIND_STRIP:RemoveKeybindButtonGroup(keystripButtons)

        scene:RemoveFragmentGroup(FRAGMENT_GROUP.GAMEPAD_KEYBIND_STRIP_GROUP)
        SCENE_MANAGER:Hide(sceneName)

        local menu = GetRadialMenu()
        menu:SelectCurrentEntry()
        menu:Clear()

        RETICLE:RequestHidden(false)
        LockCameraRotation(false)
    end
end

function ZRM.Initialize()

end

PowerCommuter.ZoneRadialMenu = ZRM