PowerCommuter = {}
PowerCommuter.name = "PowerCommuter"

local function OnAddOnLoaded(event, addonName)
    if addonName == PowerCommuter.name then
        PowerCommuter.UserSettings.Initialize()
        PowerCommuter.KeyBindings.Initialize()
        PowerCommuter.WorldMapJump.Initialize()
    end
end

SLASH_COMMANDS["/go"] = function(args)
    local jumpResult = Teleport.JumpToZone(args)

    if jumpResult then
        df("Jumping to %s", jumpResult.characterInfo.zoneName)
    else
        df("Could not jump")
    end
end

EVENT_MANAGER:RegisterForEvent(PowerCommuter.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)