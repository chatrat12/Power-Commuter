local FriendUtils = {}
local PlayerInfo = PowerCommuter.PlayerInfo

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

function FriendUtils.GetAllOnlineFriendsInfo(condition)
    return FriendUtils.GetAllFriendsInfo(function(friendInfo)
        return friendInfo.online and (condition == null or condition(friendInfo))
    end)
end

PowerCommuter.FriendUtils = FriendUtils