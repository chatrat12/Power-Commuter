Teleporter = {}
Teleporter.name = "Teleporter"
 
local GuildUtils
local FriendUtils

local function OnAddOnLoaded(event, addonName)
    if addonName == Teleporter.name then
        GuildUtils = Teleporter.GuildUtils
        FriendUtils = Teleporter.FriendUtils
    end
end

local function ListInfos(playerInfos)
    for i, player in ipairs(playerInfos) do
        if player.characterInfo.hasCharacter then
            df(string.format("%s - %s", player.displayName, player.characterInfo.zoneName))
        end
    end
end

SLASH_COMMANDS["/ttest"] = function(args)
    d("===Guild Members===")
    local onlineMembers = GuildUtils.GetAllOnlineMembersInfo()
    ListInfos(onlineMembers)

    d("===Friends===")
    local onlineFriends = FriendUtils.GetAllOnlineFriendsInfo()
    ListInfos(onlineFriends)
end

EVENT_MANAGER:RegisterForEvent(Teleporter.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)