ZRM = {}
local Shortcuts = PowerCommuter.UserSettings.JumpShortcuts
local Teleport = PowerCommuter.Teleport

local isInteracting = false
ZRM.JumpTargetCache = nil

local function PopulateEntries(menu)
    -- Cache all possible jump targets so shortcuts can look
    -- up player cout for zone
    ZRM.JumpTargetCache = Teleport.GetAllPossibleJumpTargets()

    for i = 1, Shortcuts.COUNT do
        ZRM.Entry.AddEntry(menu, i)
    end
end

function ZRM.StartInteraction()
    isInteracting = true

    -- Show keybind strip
    PowerCommuter.JumpToRadialMenu.KeybindStrip.Show()

    -- Show menu and add entries
    local menu = ZRM.Control.Get()
    PopulateEntries(menu)
    menu:Show()

    -- Disable camera controls and reticle
    LockCameraRotation(true)
    RETICLE:RequestHidden(true)    
end

function ZRM.StopInteraction()
    if isInteracting then
        isInteracting = false

        -- Hide Keybind strip
        PowerCommuter.JumpToRadialMenu.KeybindStrip.Hide()

        -- Hide menu and selet entry
        local menu = ZRM.Control.Get()
        menu:SelectCurrentEntry()
        menu:Clear()

        -- Enable camera controls and reticle
        LockCameraRotation(false)
        RETICLE:RequestHidden(false)
    end
end

PowerCommuter.JumpToRadialMenu = ZRM