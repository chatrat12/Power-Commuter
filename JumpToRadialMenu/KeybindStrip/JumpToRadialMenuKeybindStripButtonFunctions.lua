local BF = {}
local Shortcuts = PowerCommuter.UserSettings.JumpShortcuts
local Bold = PowerCommuter.ESOUtils.Bold

function BF.AssignJumpShortcut()
    local menu = PowerCommuter.JumpToRadialMenu.Control:Get()
    if menu.selectedEntry then
        -- Set shortcut
        local index = menu.selectedEntry.index
        Shortcuts.SetZoneShortcutFromCurrent(index)

        -- Print message
        shortcutName = string.format("Jump Shortcut %d", index)
        zoneName = GetZoneNameById(Shortcuts.Data[index].data.zoneID)
        df("%s set to: %s", Bold(shortcutName), Bold(zoneName))
        
        -- Close radial menu
        menu.selectedEntry = nil
        ZRM.StopInteraction()
    end
end

function BF.ClearJumpShortcut()
    local menu = PowerCommuter.JumpToRadialMenu.Control:Get()
    if menu.selectedEntry then
        -- Clear shortcut
        local index = menu.selectedEntry.index
        Shortcuts.ClearShortcut(index)

        -- Print message
        shortcutName = string.format("Jump Shortcut %d", index)
        df("%s cleared", Bold(shortcutName))

        -- Close radial menu
        menu.selectedEntry = nil
        ZRM.StopInteraction()
    end
end

PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions = BF