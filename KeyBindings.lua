local Teleport = Teleporter.Teleport
local KeyBindings = {}
local Bindings

function SetKeybinding(index, zoneName)
    local zoneID = GetZoneID(GetCurrentMapZoneIndex())
    d(zoneID)
end

function KeyBindings.Initialize()
    Bindings = Teleporter.UserSettings.KeyBindings
    SLASH_COMMANDS["/setkb"] = function(args)
        local zoneID = GetZoneId(GetCurrentMapZoneIndex())
        Bindings[1] = zoneID
        d(Teleporter.UserSettings.KeyBindings[1])
    end

    SLASH_COMMANDS["/getkb"] = function(args)
        d(Bindings[1])
    end

    SLASH_COMMANDS["/gokb"] = function(args)
        if Bindings[1] then
            local zoneName = GetZoneNameById(Bindings[1])
            Teleport.JumpToZone(zoneName)
        end
    end
end

Teleporter.KeyBindings = KeyBindings