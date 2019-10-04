local WorldMapJump = {}
local currentZonePlayerCount = 0

local function UpdateZoneCount()
    local zoneName = GetZoneNameByIndex(GetCurrentMapZoneIndex())
    currentZonePlayerCount = PowerCommuter.Teleport.PossibleJumpTargetCount(zoneName)
end

-- Can Jump
function WorldMapJump.CanJump()
    return currentZonePlayerCount > 0
end

-- Jump
function WorldMapJump.Jump()
    -- Get zone name
    local zoneName = GetZoneNameByIndex(GetCurrentMapZoneIndex())
    -- Close map
    ZO_WorldMap_HideWorldMap()
    -- Jump to zone
    PowerCommuter.Teleport.JumpToZone(zoneName)
end

-- On Map Shown
function WorldMapJump.OnMapShown()
    PowerCommuter.WorldMapJump.Buttons.Add()
end

-- On Map Hidden
function WorldMapJump.OnMapHidden()
    PowerCommuter.WorldMapJump.Buttons.Remove()
end

-- On Map Updated
function WorldMapJump.OnMapUpdated()
    UpdateZoneCount()
    PowerCommuter.WorldMapJump.Buttons.Update()
end

-- Initialize
function WorldMapJump.Initialize()
    PowerCommuter.WorldMapJump.Events.Register()
end

PowerCommuter.WorldMapJump = WorldMapJump