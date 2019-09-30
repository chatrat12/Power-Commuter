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

local function SearchForExactZoneName(playersInfo, zoneNameLower)
    for i, playerInfo in ipairs(playersInfo) do
        if playerInfo.characterInfo.zoneNameLower == zoneNameLower then
            return playerInfo
        end
    end
    return nil
end

local function SearchForFuzzyZoneName(playersInfo, zoneNameLower)
    for i, playerInfo in ipairs(playersInfo) do
        if string.find(playerInfo.characterInfo.zoneNameLower, zoneNameLower) then
            return playerInfo
        end
    end
    return nil
end

-- Jump to Zone
-- Returns playerInfo is able to jump.
function Teleport.JumpToZone(zoneName)
    local jumpTargets = Teleport.GetAllPossibleJumpTargets()
    zoneNameLower = string.lower(zoneName)

    -- First search for exact match, then for fuzzy match.
    local match = SearchForExactZoneName(jumpTargets, zoneNameLower) or SearchForFuzzyZoneName(jumpTargets, zoneNameLower)
    
    -- If match found, teleport to match and return it
    if match then
        Teleport.JumpToPlayer(match)
        return match
    end
    -- No match found
    return nil
end


Teleporter.Teleport = Teleport