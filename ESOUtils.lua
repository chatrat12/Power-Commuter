local ESOUtils = {}

function ESOUtils.Bold(msg)
    return string.format("|c%s%s|r", "ffaa00", msg)
end

PowerCommuter.ESOUtils = ESOUtils