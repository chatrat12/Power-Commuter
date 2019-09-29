local FriendUtils = {}
local PlayerInfo = Teleporter.PlayerInfo

function FriendUtils.GetAllFriendsInfo(condition)
    local result = {}
    local friendCount = GetNumFriends()

    for friendIndex = 1, friendCount do
        local friendInfo = PlayerInfo.FromFriend(friendIndex);
        if condition == null or condition(friendInfo) then
            table.insert(result, friendInfo)
        end
    end
    return result
end

function FriendUtils.GetAllOnlineFriendsInfo()
    return FriendUtils.GetAllFriendsInfo(function(friendInfo)
        return friendInfo.online
    end)
end

Teleporter.FriendUtils = FriendUtils