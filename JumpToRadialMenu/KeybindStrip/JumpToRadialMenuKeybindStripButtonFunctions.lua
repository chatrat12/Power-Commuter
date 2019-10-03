local BF = {}

function BF.AssignJumpToShortcut()
    local menu = PowerCommuter.JumpToRadialMenu.Control:Get()
    if menu.selectedEntry then
        local index = menu.selectedEntry.index
        PowerCommuter.KeyBindings.SetKeybindingToCurrentZone(index)
        df("Jump To %d set to: %s", index, GetZoneNameById(PowerCommuter.UserSettings.KeyBindings[index]))
        menu.selectedEntry = nil
        ZRM.StopInteraction()
    end
end

function BF.ClearJumpToShortcut()
    local menu = PowerCommuter.JumpToRadialMenu.Control:Get()
    if menu.selectedEntry then
        local index = menu.selectedEntry.index
        PowerCommuter.KeyBindings.ClearKeybinding(index)
        df("Jump To %d cleared", index)
        menu.selectedEntry = nil
        ZRM.StopInteraction()
    end
end

PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions = BF