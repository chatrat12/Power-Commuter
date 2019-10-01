ZRM = {}
local KeyBindings = PowerCommuter.KeyBindings
local Teleport = PowerCommuter.Teleport
local LuaUtils = PowerCommuter.LuaUtils
local Bindings = nil

local keyboardMenu
local gamepadMenu
local isInteracting = false

local function CreateRadialMenu(control, template)
    local result = ZO_RadialMenu:New(control, template, "DefaultRadialMenuAnimation", "DefaultRadialMenuEntryAnimation", "RadialMenu")
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
    end
end

function ZRM.StartInteraction()

    local menu = GetRadialMenu();
    PopulateEntries(menu)
    menu:Show()

    LockCameraRotation(true)
    RETICLE:RequestHidden(true)    
    isInteracting = true
end

function ZRM.StopInteraction()
    if isInteracting then
        local menu = GetRadialMenu()
        menu:SelectCurrentEntry()
        menu:Clear()

        RETICLE:RequestHidden(false)
        LockCameraRotation(false)
    end
end

PowerCommuter.ZoneRadialMenu = ZRM