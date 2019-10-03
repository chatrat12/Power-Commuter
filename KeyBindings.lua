local Teleport = PowerCommuter.Teleport
local ESOUtils = PowerCommuter.ESOUtils

local KeyBindings = {}
KeyBindings.BINDINGS_COUNT = 8
local Bindings

function KeyBindings.SetKeybindingToCurrentZone(index)
    local zoneID = GetZoneId(GetCurrentMapZoneIndex())
    Bindings[index] = zoneID
end

function KeyBindings.ClearKeybinding(index)
    Bindings[index] = nil
end

local function GetIndexFromArgs(args)
    if not args then return nil end
    local index = tonumber(args)
    if type(index) ~= "number" then return nil end
    index = math.floor(index)
    if index <= 0 or index > KeyBindings.BINDINGS_COUNT then
        return nil
    end
    return index
end

local function InitSlashCommands()
    SLASH_COMMANDS["/setkb"] = function(args)
        local index = SetKeybindingToCurrentZone(args)
        
        if index then
            KeyBindings.SetKeybinding(index)
            d("Binding set.")
        else
            d("Invalid bind index.")
        end
    end

    SLASH_COMMANDS["/clearkb"] = function(args)
        local index = GetIndexFromArgs(args)
        
        if index then
            Bindings[index] = nil
            d("Binding cleared.")
        else
            d("Invalid bind index.")
        end
    end
end

local function InitBindingNames()
    ZO_CreateStringId("SI_BINDING_NAME_POWERCOMMUTER_WORLD_MAP_JUMP", "World Map Jump")
    ZO_CreateStringId("SI_BINDING_NAME_POWERCOMMUTER_ZONE_RADIAL_MENU", "Zone Radial Menu")
    for i = 1, KeyBindings.BINDINGS_COUNT do
        ZO_CreateStringId(string.format("SI_BINDING_NAME_POWERCOMMUTER_JUMP_%s", i), 
                          string.format("Jump to Zone %s", i))

    end
end

function KeyBindings.JumpKeybindDown(jumpKeybindIndex)
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
    Bindings = PowerCommuter.UserSettings.KeyBindings
    InitSlashCommands()
    InitBindingNames()
end

PowerCommuter.KeyBindings = KeyBindings