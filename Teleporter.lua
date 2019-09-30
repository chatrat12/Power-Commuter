Teleporter = {}
Teleporter.name = "Teleporter"

local MapDatabase
local GuildUtils
local FriendUtils
local Teleport


local function OnAddOnLoaded(event, addonName)
    if addonName == Teleporter.name then
        MapDatabase = Teleporter.MapDatabase
        GuildUtils = Teleporter.GuildUtils
        FriendUtils = Teleporter.FriendUtils
        Teleport = Teleporter.Teleport
        Teleporter.UserSettings.Initialize()
        Teleporter.KeyBindings.Initialize()
    end
end

local function ListInfos(playerInfos)
    for i, player in ipairs(playerInfos) do
        if player.characterInfo.hasCharacter then
            df(string.format("%s - %s", player.displayName, player.characterInfo.zoneName))
        end
    end
end

local function PrintTest()
    d("===Guild Members===")
    local onlineMembers = GuildUtils.GetAllOnlineMembersInfo()
    ListInfos(onlineMembers)

    d("===Friends===")
    local onlineFriends = FriendUtils.GetAllOnlineFriendsInfo()
    ListInfos(onlineFriends)
end

SLASH_COMMANDS["/ttest"] = function(args)
    for i = 1, Teleporter.KeyBindings.BINDINGS_COUNT do
        df("SI_BINDING_NAME_TELEPORTER_JUMP_%s", i)
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

EVENT_MANAGER:RegisterForEvent(Teleporter.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)