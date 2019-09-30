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

local function GetCharacterInfo(characterInfoFunction)
    local hasCharacter, characterName, zoneName, classtype, alliance = characterInfoFunction()

    return
    {
        hasCharacter = hasCharacter,
        characterName = characterName,
        zoneName = zoneName
    }
end

local function GenerateInfo(relationship, displayName, status, secsSinceLogoff, characterInfoFunction)
    return
    {
        relationship = relationship,
        displayName = displayName,
        online = playerStatus ~= PLAYER_STATUS_OFFLINE and secsSinceLogoff == 0,
        characterInfo = GetCharacterInfo(characterInfoFunction)
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

Teleporter.PlayerInfo = PlayerInfo