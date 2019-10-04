local function GetAssignShortcut()
    if IsInGamepadPreferredMode() then
        return "UI_SHORTCUT_LEFT_SHOULDER"
    else
        return "UI_SHORTCUT_PRIMARY"
    end
end

local function GetClearShortcut()
    if IsInGamepadPreferredMode() then
        return "UI_SHORTCUT_RIGHT_SHOULDER"
    else
        return "UI_SHORTCUT_NEGATIVE"
    end
end

local buttons = 
{
    {
        name = "Assign Location",
        callback = function() 
            PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions.AssignJumpShortcut()
        end
    },
    {
        name = "Clear Location",
        callback = function() 
            PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions.ClearJumpShortcut()
        end
    },
    alignment = KEYBIND_STRIP_ALIGN_CENTER
}

PowerCommuter.JumpToRadialMenu.KeybindStrip.Buttons = {}
function PowerCommuter.JumpToRadialMenu.KeybindStrip.Buttons.Get()
    buttons[1].keybind = GetAssignShortcut()
    buttons[2].keybind = GetClearShortcut()
    return buttons
end