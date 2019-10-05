local JS = {}

JS.TYPE = 
{
    ZONE = 0,
    OWNED_HOUSE = 1,
    NON_OWNED_HOUSE = 2
}

function JS.CreateFromZoneID(zoneID)
    return
    {
        type = JS.TYPE.ZONE,
        data = { zoneID = zoneID }
    }
end

function JS.CreateFromHouseID(houseID)
    return
    {
        type = JS.TYPE.OWNED_HOUSE,
        data = { houseID = houseID }
    }
end

function JS.CreateFromHouseOwner(houseOwner)
    return
    {
        type = JS.TYPE.NON_OWNED_HOUSE,
        data = { houseOwner = houseOwner }
    }
end

function JS.CreatefromCurrentLocation()
    if PowerCommuter.HouseUtils.InHouse() then
        if PowerCommuter.HouseUtils.InOwnHouse() then
            return JS.CreateFromHouseID(GetCurrentZoneHouseId())
        else
            return JS.CreateFromHouseOwner(GetCurrentHouseOwner())
        end
    end
    return JS.CreateFromZoneID(GetZoneId(GetCurrentMapZoneIndex()))
end


PowerCommuter.UserSettings.JumpShortcut = JS