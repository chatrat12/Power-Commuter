local HU = {}


function HU.InHouse()
    local houseOwner = GetCurrentHouseOwner()
    return houseOwner ~= nil and houseOwner ~= ""
end

function HU.InOwnHouse()
    return GetDisplayName() == GetCurrentHouseOwner()
end

function HU.GetCurrentHouseData()
    if HU.InOwnHouse() then
        return { houseID = GetCurrentZoneHouseId() }
    else
        return { houseOwner = GetCurrentHouseOwner() }
    end
end

function HU.GetHouseNameFromHouseID(houseID)
    local houseCollectibleId = GetCollectibleIdForHouse(houseID)
    local houseCollectibleData = ZO_COLLECTIBLE_DATA_MANAGER:GetCollectibleDataById(houseCollectibleId)
    return houseCollectibleData:GetFormattedName()
end

PowerCommuter.HouseUtils = HU