local JS = {}

JS.TYPE = 
{
    ZONE = 0,
    PLAYER_HOUSE = 1,
    PLAYER_PRIMARY_RESIDENCE = 2
}

function JS.CreateFromZoneID(zoneID)
    return
    {
        type = JS.TYPE.ZONE,
        data = 
        {
            zoneID = zoneID
        }
    }
end

PowerCommuter.UserSettings.JumpShortcut = JS