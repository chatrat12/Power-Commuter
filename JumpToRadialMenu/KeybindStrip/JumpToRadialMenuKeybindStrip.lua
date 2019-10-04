local KS = {}

-- Create scenes
local gamepadSceneName = "pw_radial_menu_keybind_strip_gamepad"
local gamepadScene = ZO_Scene:New(gamepadSceneName, SCENE_MANAGER)

local keyboardSceneName = "pw_radial_menu_keybind_strip_keyboard"
local keyboardScene = ZO_Scene:New(keyboardSceneName, SCENE_MANAGER)


-- Add fragments to scenes
gamepadScene:AddFragment(GAMEPAD_UI_MODE_FRAGMENT)
gamepadScene:AddFragment(UI_SHORTCUTS_ACTION_LAYER_FRAGMENT)
gamepadScene:AddFragmentGroup(FRAGMENT_GROUP.GAMEPAD_KEYBIND_STRIP_GROUP)

keyboardScene:AddFragment(HIDE_MOUSE_FRAGMENT)
keyboardScene:AddFragment(UI_SHORTCUTS_ACTION_LAYER_FRAGMENT)
keyboardScene:AddFragmentGroup(FRAGMENT_GROUP.KEYBOARD_KEYBIND_STRIP_GROUP)

-- Keep track of last scene shown
local lastShownScene = nil

local function GetNameOfSceneToShow()
    if IsInGamepadPreferredMode() then
        return gamepadSceneName
    else
        return keyboardSceneName
    end
end

function KS.Show()
    lastShownScene = GetNameOfSceneToShow()
    SCENE_MANAGER:Show(lastShownScene)
    KEYBIND_STRIP:AddKeybindButtonGroup(PowerCommuter.JumpToRadialMenu.KeybindStrip.Buttons.Get())
    HideMouse()
end

function KS.Hide()
    KEYBIND_STRIP:RemoveKeybindButtonGroup(PowerCommuter.JumpToRadialMenu.KeybindStrip.Buttons.Get())
    SCENE_MANAGER:Hide(lastShownScene)
    ShowMouse()
end

PowerCommuter.JumpToRadialMenu.KeybindStrip = KS