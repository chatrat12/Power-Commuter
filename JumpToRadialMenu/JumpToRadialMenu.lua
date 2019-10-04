ZRM = {}
local Shortcuts = PowerCommuter.UserSettings.JumpShortcuts
local SHORTCUT_TYPE = PowerCommuter.UserSettings.JumpShortcut.TYPE
local Teleport = PowerCommuter.Teleport
local LuaUtils = PowerCommuter.LuaUtils

local isInteracting = false

local function RemapIndex(index)
    index = 9 - index - 4
    if index < 1 then
        index = index + 8
    end
    return index
end

local function PopulateEntries(menu)
    local emptyIcon = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds"
    local zoneIcon = "EsoUI/Art/WorldMap/map_indexIcon_locations_up.dds"

    local possibleJumpTargets = Teleport.GetAllPossibleJumpTargets()

    for i = 1, Shortcuts.COUNT do

        local mappedIndex = RemapIndex(i)
        local text = "Not Set"
        local icon = emptyIcon
        local shortcut = Shortcuts.Data[mappedIndex]

        if shortcut then
            if shortcut.type == SHORTCUT_TYPE.ZONE then
                local zoneName = GetZoneNameById(shortcut.data.zoneID)
                local playerCount = LuaUtils.Count(possibleJumpTargets, function(playerInfo)
                    return playerInfo.characterInfo.zoneName == zoneName
                end)
                text = string.format("%s (%s)", zoneName, playerCount)
                icon = zoneIcon
            end
        end

        local jumpFunc = function()
            PowerCommuter.KeyBindings.JumpKeybindDown(mappedIndex)
        end

        menu:AddEntry(text, icon, icon, jumpFunc, nil)
        menu.entries[i].index = mappedIndex
    end
end

function ZRM.StartInteraction()
    isInteracting = true

    -- Show keybind strip
    PowerCommuter.JumpToRadialMenu.KeybindStrip.Show()

    -- Show menu and add entries
    local menu = ZRM.Control.Get()
    PopulateEntries(menu)
    menu:Show()

    -- Disable camera controls and reticle
    LockCameraRotation(true)
    RETICLE:RequestHidden(true)    
end

function ZRM.StopInteraction()
    if isInteracting then
        isInteracting = false

        -- Hide Keybind strip
        PowerCommuter.JumpToRadialMenu.KeybindStrip.Hide()

        -- Hide menu and selet entry
        local menu = ZRM.Control.Get()
        menu:SelectCurrentEntry()
        menu:Clear()

        -- Enable camera controls and reticle
        LockCameraRotation(false)
        RETICLE:RequestHidden(false)
    end
end


PowerCommuter.JumpToRadialMenu = ZRM