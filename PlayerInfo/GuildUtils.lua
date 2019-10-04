local GuildUtils = {}
local LuaUtils = PowerCommuter.LuaUtils
local PlayerInfo = PowerCommuter.PlayerInfo

-- Get Members
function GuildUtils.GetMembersInfo(guildID, condition)

    local result = {}

    local playerIndex = GetPlayerGuildMemberIndex(guildID)
    local memberCount = GetNumGuildMembers(guildID)

    for memberIndex = 1, memberCount do
        local memberInfo = PlayerInfo.FromGuildMember(guildID, memberIndex)
        if playerIndex ~= memberIndex and (condition == nil or condition(memberInfo)) then
            table.insert(result, memberInfo);
        end
    end
    return result
end

-- Get Online Members
function GuildUtils.GetOnlineMembersInfo(guildID)
    return GuildUtils.GetMembersInfo(id, function(memberInfo)
        return memberInfo.online
    end)
end

-- Get All Members
function GuildUtils.GetAllMembersInfo(condition)
    local result = {}
    
    local guildCount = GetNumGuilds()
    for i = 1, guildCount do
        local id = GetGuildId(i)
        local onlineMembers = GuildUtils.GetMembersInfo(id, condition)
        result = LuaUtils.TableConcat(result, onlineMembers)
    end

    return result
end

-- Get All Online Members
function GuildUtils.GetAllOnlineMembersInfo(condition)
    return GuildUtils.GetAllMembersInfo(function(memberInfo)
        return memberInfo.online and (condition == null or condition(memberInfo))
    end)
end

PowerCommuter.GuildUtils = GuildUtils