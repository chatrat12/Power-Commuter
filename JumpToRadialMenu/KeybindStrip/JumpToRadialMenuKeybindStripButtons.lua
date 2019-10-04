local Buttons = {}

local function CreateButtons(assignKeybind, clearKeybind)
    return 
    {
        {
            name = "Assign Location",
            keybind = assignKeybind,
            callback = function() 
                PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions.AssignJumpShortcut()
            end
        },
        {
            name = "Clear Location",
            keybind = clearKeybind,
            callback = function() 
                PowerCommuter.JumpToRadialMenu.KeybindStrip.ButtonFunctions.ClearJumpShortcut()
            end
        },
        alignment = KEYBIND_STRIP_ALIGN_CENTER
    }
end

local gamepadButtons = CreateButtons("UI_SHORTCUT_LEFT_SHOULDER", "UI_SHORTCUT_RIGHT_SHOULDER")
local keyboardButtons = CreateButtons("UI_SHORTCUT_PRIMARY", "UI_SHORTCUT_NEGATIVE")
local lastAddedButtons = nil

local function GetButtonsToAdd()
    if IsInGamepadPreferredMode() then
        return gamepadButtons
    else
        return keyboardButtons
    end
end

function Buttons.Add()
    lastAddedButtons = GetButtonsToAdd();
    KEYBIND_STRIP:AddKeybindButtonGroup(lastAddedButtons)
end

function Buttons.Remove()
    if lastAddedButtons then
        KEYBIND_STRIP:RemoveKeybindButtonGroup(lastAddedButtons)
    end
end

PowerCommuter.JumpToRadialMenu.KeybindStrip.Buttons = Buttons