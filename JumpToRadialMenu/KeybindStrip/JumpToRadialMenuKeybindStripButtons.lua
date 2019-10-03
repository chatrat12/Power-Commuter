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

PowerCommuter.JumpToRadialMenu.KeybindStrip.Buttons = 
{
    {
        name = "Assign Location",
        keybind = GetAssignShortcut(),
        callback = function() 
            PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions.AssignJumpToShortcut()
        end
    },
    {
        name = "Clear Location",
        keybind = GetClearShortcut(),
        callback = function() 
            PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions.ClearJumpToShortcut()
        end
    },
    alignment = KEYBIND_STRIP_ALIGN_CENTER
}