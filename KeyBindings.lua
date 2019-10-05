local KeyBindings = {}
local Shortcuts = PowerCommuter.UserSettings.JumpShortcuts
local Bold = PowerCommuter.ESOUtils.Bold
local SHORTCUT_TYPE = PowerCommuter.UserSettings.JumpShortcut.TYPE


-- Init Binding Names
ZO_CreateStringId("SI_BINDING_NAME_POWERCOMMUTER_WORLD_MAP_JUMP", "World Map Jump")
ZO_CreateStringId("SI_BINDING_NAME_POWERCOMMUTER_ZONE_RADIAL_MENU", "Zone Radial Menu")
for i = 1, Shortcuts.COUNT do
    ZO_CreateStringId(string.format("SI_BINDING_NAME_POWERCOMMUTER_JUMP_%s", i), 
                      string.format("Jump to Zone %s", i))
end

function KeyBindings.JumpKeybindDown(shortcutIndex)
    local shortcut = Shortcuts.Data[shortcutIndex]
    if shortcut then
        if shortcut.type == SHORTCUT_TYPE.ZONE then
            local zoneName = GetZoneNameById(shortcut.data.zoneID)
            local playerInfo = PowerCommuter.Teleport.JumpToZone(zoneName)
            
            if playerInfo then
                df("Jumping to %s",  Bold(playerInfo.characterInfo.zoneName))
            else
                d("Could not find player to jump to.")
            end
        elseif shortcut.type == SHORTCUT_TYPE.OWNED_HOUSE then
            RequestJumpToHouse(shortcut.data.houseID)
            local houseName = PowerCommuter.HouseUtils.GetHouseNameFromHouseID(shortcut.data.houseID)
            df("Jumping to %s", Bold(houseName))
        elseif shortcut.type == SHORTCUT_TYPE.NON_OWNED_HOUSE then
            JumpToHouse(shortcut.data.houseOwner)
            df("Jumping to %s's House", Bold(shortcut.data.houseOwner))
        end
    else -- Shorcut not set
        df("%s Not Set", Bold(string.format("Jump to %s", shortcutIndex)))
    end
end

PowerCommuter.KeyBindings = KeyBindings