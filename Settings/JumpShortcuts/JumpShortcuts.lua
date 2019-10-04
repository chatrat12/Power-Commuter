local JS = {}

JS.COUNT = 8

JS.Data = nil

function JS.SetShortcut(index, shortcut)
    JS.Data[index] = shortcut
end

function JS.SetZoneShortcut(index, zoneID)
    local shortcut = PowerCommuter.UserSettings.JumpShortcut.CreateFromZoneID(zoneID)
    JS.SetShortcut(index, shortcut)
end

function JS.SetZoneShortcutFromCurrent(index, zoneID)
    local zoneID = GetZoneId(GetCurrentMapZoneIndex())
    local shortcut = PowerCommuter.UserSettings.JumpShortcut.CreateFromZoneID(zoneID)
    JS.SetShortcut(index, shortcut)
end

function JS.ClearShortcut(index)
    JS.Data[index] = nil
end

PowerCommuter.UserSettings.JumpShortcuts = JS