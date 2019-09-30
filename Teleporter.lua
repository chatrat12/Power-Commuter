Teleporter = {}
Teleporter.name = "Teleporter"
 
local GuildUtils
local FriendUtils
local Teleport

local function OnAddOnLoaded(event, addonName)
    if addonName == Teleporter.name then
        GuildUtils = Teleporter.GuildUtils
        FriendUtils = Teleporter.FriendUtils
        Teleport = Teleporter.Teleport
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
    local possibleTargets = Teleport.GetAllPossibleJumpTargets();
    d(possibleTargets)
end

SLASH_COMMANDS["/go"] = function(args)
    if Teleport.JumpToZone(args) then
        df("Jumping to %s", args)
    else
        df("Could not jump")
    end
end

EVENT_MANAGER:RegisterForEvent(Teleporter.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)