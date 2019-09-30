local Teleport = {}
local PlayerInfo = Teleporter.PlayerInfo
local GuildUtils = Teleporter.GuildUtils
local FriendUtils = Teleporter.FriendUtils
local LuaUtils = Teleporter.LuaUtils

function Teleport.GetAllPossibleJumpTargets()
    local onlineFriends = FriendUtils.GetAllOnlineFriendsInfo()

    -- Don't add guild members if they are a friend of the player
    local onlineGuildMembers = GuildUtils.GetAllOnlineMembersInfo(function(memberInfo)
        return not IsFriend(memberInfo.displayName)
    end)

    -- Combine results
    return LuaUtils.TableConcat(onlineFriends, onlineGuildMembers)
end

function Teleport.JumpToPlayer(playerInfo)
    if playerInfo.relationship == PlayerInfo.RELATIONSHIP_FRIEND then
        JumpToFriend(playerInfo.displayName)
    elseif playerInfo.relationship == PlayerInfo.RELATIONSHIP_GUILD then
        JumpToGuildMember(playerInfo.displayName)
    end
end

-- Jump to Zone
-- Returns true if player was able to jump to zone.
function Teleport.JumpToZone(zoneName)
    local jumpTargets = Teleport.GetAllPossibleJumpTargets()
    for i, possibleTarget in ipairs(jumpTargets) do
        if possibleTarget.characterInfo.zoneName == zoneName then
            Teleport.JumpToPlayer(possibleTarget)
            return true
        end
    end
    return false
end


Teleporter.Teleport = Teleport