local RC = {}

local keyboardMenu
local gamepadMenu

local function CreateRadialMenu(control, template)
    local result = ZO_RadialMenu:New(control, template, "DefaultRadialMenuAnimation", "DefaultRadialMenuEntryAnimation", "RadialMenu")
    result:SetOnClearCallback(function() ZRM.StopInteraction() end)
    return result
end

local function GetKeyboardMenu()
    if not keyboardMenu then
        keyboardMenu = CreateRadialMenu(JumpToRadialMenu_Keyboard, "ZO_PlayerToPlayerMenuEntryTemplate_Keyboard")
    end
    return keyboardMenu
    
end

local function GetGamepadMenu()
    if not gamepadMenu then
        gamepadMenu = CreateRadialMenu(JumpToRadialMenu_Gamepad, "ZO_RadialMenuHUDEntryTemplate_Gamepad")
    end
    return gamepadMenu
end

function RC.Get()
    if IsInGamepadPreferredMode() then
        return GetGamepadMenu()
    else
        return GetKeyboardMenu()
    end
end

PowerCommuter.JumpToRadialMenu.Control = RC