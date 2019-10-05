local Entry = {}
local Shortcuts = PowerCommuter.UserSettings.JumpShortcuts
local SHORTCUT_TYPE = PowerCommuter.UserSettings.JumpShortcut.TYPE
local Count = PowerCommuter.LuaUtils.Count

-- Icons
local emptyIcon = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds"
local zoneIcon = "EsoUI/Art/WorldMap/map_indexIcon_locations_up.dds"
local houseIcon = "EsoUI/Art/WorldMap/map_indexIcon_housing_up.dds"

-- Returns function to be called by entry.
local function GetEntryFunction(shorctuIndex)
    return function()
        PowerCommuter.KeyBindings.JumpKeybindDown(shorctuIndex)
    end
end

-- Remap the entry index so that the entry at 12 o'clock
-- is the first shortcut and increments by 1 clockwise
-- INPUT:  Entry Index
-- OUTPUT: Shortcut Index
local function RemapIndex(index)
    index = 9 - index - 4
    if index < 1 then
        index = index + 8
    end
    return index
end

local emptyEntryData =
{
    text = "Not Set",
    icon = emptyIcon
}

local function GetZoneEntryData(zoneID)
    -- Get Zone name
    local zoneName = GetZoneNameById(zoneID)
    -- Get how many players can be jumped to for zone
    local playerCount = Count(PowerCommuter.JumpToRadialMenu.JumpTargetCache, function(playerInfo)
        return playerInfo.characterInfo.zoneName == zoneName
    end)
    return
    {
        text = string.format("%s (%s)", zoneName, playerCount),
        icon = zoneIcon
    }
end

local function GetOwnedHouseEntryData(houseID)
    local houseInfo = GetCollectibleIdForHouse(houseID)
    return
    {
        text = PowerCommuter.HouseUtils.GetHouseNameFromHouseID(houseID),
        icon = houseIcon
    }
end

local function GetNonOwnedHouseEntryData(houseOwner)
    return
    {
        text = string.format("%s's House", houseOwner),
        icon = houseIcon
    }
end

function Entry.AddEntry(menu, entryIndex)
    -- Entry index to shortcut index
    local shortcutIndex = RemapIndex(entryIndex)
    local shortcut = Shortcuts.Data[shortcutIndex];
    -- Entry data defaults
    local entryData = emptyEntryData


    if shortcut then
        if shortcut.type == SHORTCUT_TYPE.ZONE then -- Shortcut is zone shortcut
            entryData = GetZoneEntryData(shortcut.data.zoneID)
        elseif shortcut.type == SHORTCUT_TYPE.OWNED_HOUSE then
            entryData = GetOwnedHouseEntryData(shortcut.data.houseID)
        elseif shortcut.type == SHORTCUT_TYPE.NON_OWNED_HOUSE then
            entryData = GetNonOwnedHouseEntryData(shortcut.data.houseOwner)
        end
    end

    menu:AddEntry(entryData.text, entryData.icon, entryData.icon, GetEntryFunction(shortcutIndex))
    menu.entries[entryIndex].index = shortcutIndex
end

PowerCommuter.JumpToRadialMenu.Entry = Entry