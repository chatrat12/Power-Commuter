local WME = {}

local function AddMapFragmentEvents()
    WORLD_MAP_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_FRAGMENT_SHOWING then
            PowerCommuter.WorldMapJump.OnMapShown()
        elseif newState == SCENE_FRAGMENT_HIDING then
            PowerCommuter.WorldMapJump.OnMapHidden()
        end
    end)
end

local function AddMapChangeCallback()
    CALLBACK_MANAGER:RegisterCallback("OnWorldMapChanged", function()
        PowerCommuter.WorldMapJump.OnMapUpdated()
    end)
end

function WME.Register()
    AddMapFragmentEvents()
    AddMapChangeCallback()
end

PowerCommuter.WorldMapJump.Events = WME