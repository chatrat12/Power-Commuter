local Teleport = Teleporter.Teleport
local ESOUtils = Teleporter.ESOUtils

local KeyBindings = {}
KeyBindings.BINDINGS_COUNT = 8
local Bindings

function SetKeybinding(index, zoneName)
    local zoneID = GetZoneID(GetCurrentMapZoneIndex())
    d(zoneID)
end

local function InitSlashCommands()
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

local function InitBindingNames()
    for i = 1, KeyBindings.BINDINGS_COUNT do
        ZO_CreateStringId(string.format("SI_BINDING_NAME_TELEPORTER_JUMP_%s", i), 
                          string.format("Jump to Zone %s", i))

    end
end

function KeyBindings.JumpKeybindDown(jumpKeybindIndex)
    d(jumpKeybindIndex)
    if Bindings[jumpKeybindIndex] then
        local zoneName = GetZoneNameById(Bindings[jumpKeybindIndex])

        local playerInfo = Teleport.JumpToZone(zoneName)
        
        if playerInfo then
            df("Jumping to |cffaa00%s|r", playerInfo.characterInfo.zoneName)
        else
            d("Could not find player to jump to.")
        end

    else
        df("%s Keybinding Not Set", ESOUtils.Bold(string.format("Jump to Zone %s", jumpKeybindIndex)))
    end
end

function KeyBindings.Initialize()
    Bindings = Teleporter.UserSettings.KeyBindings
    InitSlashCommands()
    InitBindingNames()
end

Teleporter.KeyBindings = KeyBindings