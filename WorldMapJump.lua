local WorldMapJump = {}
local Teleport = PowerCommuter.Teleport

function WorldMapJump.Initialize()

    local myButtonGroup = 
    {
        {
            name = "Jump To Zone",
            keybind = "UI_SHORTCUT_INPUT_RIGHT",
            callback = function() 
                local zoneName = GetZoneNameByIndex(GetCurrentMapZoneIndex())
                ZO_WorldMap_HideWorldMap()
                Teleport.JumpToZone(zoneName)
            end,
            visible = function()
                local zoneName = GetZoneNameByIndex(GetCurrentMapZoneIndex())
                return Teleport.PossibleJumpTargetCount(zoneName) > 0
            end
        },
        alignment = KEYBIND_STRIP_ALIGN_RIGHT,
    }

    WORLD_MAP_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_FRAGMENT_SHOWING then
            KEYBIND_STRIP:AddKeybindButtonGroup(myButtonGroup)
        elseif newState == SCENE_FRAGMENT_HIDING then
            KEYBIND_STRIP:RemoveKeybindButtonGroup(myButtonGroup)
        elseif newState == SCENE_FRAGMENT_HIDDEN then
        end
    end)

    CALLBACK_MANAGER:RegisterCallback("OnWorldMapChanged", function()
        KEYBIND_STRIP:UpdateKeybindButtonGroup(myButtonGroup)
    end)
end

PowerCommuter.WorldMapJump = WorldMapJump