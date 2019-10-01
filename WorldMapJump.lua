local WorldMapJump = {}
local Teleport = PowerCommuter.Teleport

local currentZonePlayerCount = 0

local buttonName = "Jump to Zone"
local buttonCallback = function()
    local zoneName = GetZoneNameByIndex(GetCurrentMapZoneIndex())
    ZO_WorldMap_HideWorldMap()
    Teleport.JumpToZone(zoneName)
end
local visibleCallback = function()
    return currentZonePlayerCount > 0
end

local keyboardButtons = 
{
    {
        name = buttonName,
        keybind = "UI_SHORTCUT_QUATERNARY",
        callback = buttonCallback,
        visible = visibleCallback
    },
    alignment = KEYBIND_STRIP_ALIGN_CENTER
}

local function HackLegendButton()
    bind = KEYBIND_STRIP.keybinds["UI_SHORTCUT_LEFT_STICK"]
    if bind then
        bind.keybindButtonDescriptor.name = "Jump to Zone"
        bind.keybindButtonDescriptor.callback = buttonCallback
        bind.keybindButtonDescriptor.visible = visibleCallback
    end
end

local function AddButtons()
    if IsInGamepadPreferredMode() then
        HackLegendButton();
    else
        KEYBIND_STRIP:AddKeybindButtonGroup(keyboardButtons)
    end
end

local function RemoveButtons()
    if not IsInGamepadPreferredMode() then
        KEYBIND_STRIP:AddKeybindButtonGroup(keyboardButtons)
    end
end

local function UpdateZoneCount()
    local zoneName = GetZoneNameByIndex(GetCurrentMapZoneIndex())
    currentZonePlayerCount = Teleport.PossibleJumpTargetCount(zoneName)
end

local function OnMapUpdated()

    UpdateZoneCount()
    if not IsInGamepadPreferredMode() then
        KEYBIND_STRIP:RemoveKeybindButtonGroup(keyboardButtons)
    end
end

function WorldMapJump.Initialize()
    WORLD_MAP_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_FRAGMENT_SHOWING then
            AddButtons()
        elseif newState == SCENE_FRAGMENT_HIDING then
            RemoveButtons()
        elseif newState == SCENE_FRAGMENT_HIDDEN then
        end
    end)

    CALLBACK_MANAGER:RegisterCallback("OnWorldMapChanged", function()
        if IsInGamepadPreferredMode() then
            HackLegendButton();
        end
        OnMapUpdated()
    end)
end

PowerCommuter.WorldMapJump = WorldMapJump