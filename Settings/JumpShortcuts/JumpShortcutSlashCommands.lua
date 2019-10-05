
-- Returns nil if arg is invalid
local function GetIndexFromArgs(args)
    if not args then return nil end
    local index = tonumber(args)
    if type(index) ~= "number" then return nil end
    index = math.floor(index)
    if index <= 0 or index > PowerCommuter.UserSettings.JumpShortcuts.COUNT then
        return nil
    end
    return index
end

SLASH_COMMANDS["/pc_set"] = function(args)
    local index = GetIndexFromArgs(args)
    
    if index then
        PowerCommuter.UserSettings.JumpShortcuts.SetZoneShortcutFromCurrent(index)
        d("Binding set.")
    else
        d("Invalid bind index.")
    end
end

SLASH_COMMANDS["/pc_clear"] = function(args)
    local index = GetIndexFromArgs(args)
    
    if index then
        PowerCommuter.UserSettings.JumpShortcuts.ClearShortcut(index)
        d("Binding cleared.")
    else
        d("Invalid bind index.")
    end
end