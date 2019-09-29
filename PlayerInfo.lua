local PlayerInfo = {}

--[[

===========================
PlayerInfo table structure
===========================

PlayerInfo
.displayName
.online
.characterInfo
  .hasCharacter
  .characterName
  .zoneName

]]--

local function GetCharacterInfo(characterInfoFunction)
    local hasCharacter, characterName, zoneName, classtype, alliance = characterInfoFunction()

    return
    {
        hasCharacter = hasCharacter,
        characterName = characterName,
        zoneName = zoneName
    }
end

local function GenerateInfo(displayName, status, secsSinceLogoff, characterInfoFunction)
    return
    {
        displayName = displayName,
        online = playerStatus ~= PLAYER_STATUS_OFFLINE and secsSinceLogoff == 0,
        characterInfo = GetCharacterInfo(characterInfoFunction)
    }
end

function PlayerInfo.FromGuildMember(guildID, guildMemberIndex)
    local displayName, note, rankIndex, status, secsSinceLogoff = GetGuildMemberInfo(guildID, guildMemberIndex)
    local characterInfoFunction = function() return GetGuildMemberCharacterInfo(guildID, guildMemberIndex) end
    return GenerateInfo(displayName, status, secsSinceLogoff, characterInfoFunction)
end

function PlayerInfo.FromFriend(friendIndex)
    local displayName, note, status, secsSinceLogoff = GetFriendInfo(friendIndex)
    local characterInfoFunction = function() return GetFriendCharacterInfo(friendIndex) end
    return GenerateInfo(displayName, status, secsSinceLogoff, characterInfoFunction)
end

Teleporter.PlayerInfo = PlayerInfo