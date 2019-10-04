local WMB = {}

local buttonName = "Jump to Zone"

local keyboardButtonGroup = 
{
    {
        name = buttonName,
        keybind = "UI_SHORTCUT_QUATERNARY",
        callback = PowerCommuter.WorldMapJump.Jump,
        visible = PowerCommuter.WorldMapJump.CanJump
    },
    alignment = KEYBIND_STRIP_ALIGN_CENTER
}

local function HackLegendButton()
    bind = KEYBIND_STRIP.keybinds["UI_SHORTCUT_LEFT_STICK"]
    if bind then
        bind.keybindButtonDescriptor.name = buttonName
        bind.keybindButtonDescriptor.callback = PowerCommuter.WorldMapJump.Jump
        bind.keybindButtonDescriptor.visible = PowerCommuter.WorldMapJump.CanJump
    end
end

function WMB.Add()
    if IsInGamepadPreferredMode() then
        HackLegendButton();
    else
        KEYBIND_STRIP:AddKeybindButtonGroup(keyboardButtonGroup)
    end
end

function WMB.Remove()
    if not IsInGamepadPreferredMode() then
        KEYBIND_STRIP:RemoveKeybindButtonGroup(keyboardButtonGroup)
    end
end

function WMB.Update()
    if IsInGamepadPreferredMode() then
        HackLegendButton()
    else
        KEYBIND_STRIP:UpdateKeybindButtonGroup(keyboardButtonGroup)
    end
end

PowerCommuter.WorldMapJump.Buttons = WMB