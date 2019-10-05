local Bold = PowerCommuter.ESOUtils.Bold
local SHORTCUT_TYPE = PowerCommuter.UserSettings.JumpShortcut.TYPE
local JS = {}
JS.COUNT = 8
JS.Data = nil

function JS.SetShortcut(index, shortcut)
    JS.Data[index] = shortcut
end

function JS.SetShortcutFromCurrentLocation(index)
    local shortcut = PowerCommuter.UserSettings.JumpShortcut.CreatefromCurrentLocation()
    JS.SetShortcut(index, shortcut)

    -- Print message
    local shortcutName = string.format("Jump Shortcut %d", index)
    if shortcut.type == SHORTCUT_TYPE.ZONE then
        local zoneName = GetZoneNameById(shortcut.data.zoneID)
        df("%s set to: %s", Bold(shortcutName), Bold(zoneName))
    elseif shortcut.type == SHORTCUT_TYPE.OWNED_HOUSE then
        houseName = PowerCommuter.HouseUtils.GetHouseNameFromHouseID(shortcut.data.houseID)
        df("%s set to: %s", Bold(shortcutName), Bold(houseName))
    elseif shortcut.type == SHORTCUT_TYPE.NON_OWNED_HOUSE then
        df("%s set to: %s's House", Bold(shortcutName), Bold(shortcut.data.houseOwner))
    end
end

function JS.ClearShortcut(index)
    JS.Data[index] = nil

    -- Print message
    local shortcutName = string.format("Jump Shortcut %d", index)
    df("%s cleared", Bold(shortcutName))
end

PowerCommuter.UserSettings.JumpShortcuts = JS