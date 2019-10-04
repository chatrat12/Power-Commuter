local Teleport = {}
local PlayerInfo = PowerCommuter.PlayerInfo
local GuildUtils = PowerCommuter.GuildUtils
local FriendUtils = PowerCommuter.FriendUtils
local LuaUtils = PowerCommuter.LuaUtils

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

-- When searching for a player to jump to,
-- sort by the player with the highest level
local function playerOrder(t, a, b)
    return t[b].characterInfo.levelRank < t[a].characterInfo.levelRank
end

local function SearchForExactZoneName(playersInfo, zoneNameLower)
    for key, playerInfo in LuaUtils.SPairs(playersInfo, playerOrder) do
        if playerInfo.characterInfo.zoneNameLower == zoneNameLower then
            return playerInfo
        end
    end
    return nil
end

local function SearchForFuzzyZoneName(playersInfo, zoneNameLower)
    for key, playerInfo in LuaUtils.SPairs(playersInfo, playerOrder) do
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

function Teleport.PossibleJumpTargetCount(zoneName)
    local possibleJumpTargets = Teleport.GetAllPossibleJumpTargets()
    return LuaUtils.Count(possibleJumpTargets, function(playerInfo)
        return playerInfo.characterInfo.zoneName == zoneName
    end)
end

function Teleport.JumpToJumpShortcut(shortcut)

end

PowerCommuter.Teleport = Teleport