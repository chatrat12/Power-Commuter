local PlayerInfo = {}

--[[

===========================
PlayerInfo table structure
===========================

PlayerInfo
.relationship
.displayName
.online
.characterInfo
  .hasCharacter
  .characterName
  .zoneName

]]--

PlayerInfo.RELATIONSHIP_FRIEND = 0
PlayerInfo.RELATIONSHIP_GUILD  = 1
PlayerInfo.RELATIONSHIP_GROUP  = 2

local MAX_LEVEL = 50

local function GetLevelRank(level, veteranLevel)
    if level < MAX_LEVEL then
        return level
    else
        return level + veteranLevel
    end
end

local function GetCharacterInfo(characterInfoFunction)
    local hasCharacter, characterName, zoneName, classtype, alliance, level, veteranLevel = characterInfoFunction()

    return
    {
        hasCharacter = hasCharacter,
        characterName = characterName,
        zoneName = zoneName,
        -- Cache the zone name in lower case
        -- for searching
        zoneNameLower = string.lower(zoneName),
        levelRank = GetLevelRank(level, veteranLevel)
    }
end

local function GenerateInfo(relationship, displayName, status, secsSinceLogoff, characterInfoFunction)
    local characterInfo = GetCharacterInfo(characterInfoFunction)
    local online = playerStatus ~= PLAYER_STATUS_OFFLINE and secsSinceLogoff == 0 and characterInfo.hasCharacter

    return
    {
        relationship = relationship,
        displayName = displayName,
        online = online,
        characterInfo = characterInfo
    }
end

function PlayerInfo.FromGuildMember(guildID, guildMemberIndex)
    local displayName, note, rankIndex, status, secsSinceLogoff = GetGuildMemberInfo(guildID, guildMemberIndex)
    local characterInfoFunction = function() return GetGuildMemberCharacterInfo(guildID, guildMemberIndex) end
    return GenerateInfo(PlayerInfo.RELATIONSHIP_GUILD, displayName, status, secsSinceLogoff, characterInfoFunction)
end

function PlayerInfo.FromFriend(friendIndex)
    local displayName, note, status, secsSinceLogoff = GetFriendInfo(friendIndex)
    local characterInfoFunction = function() return GetFriendCharacterInfo(friendIndex) end
    return GenerateInfo(PlayerInfo.RELATIONSHIP_FRIEND, displayName, status, secsSinceLogoff, characterInfoFunction)
end

PowerCommuter.PlayerInfo = PlayerInfo