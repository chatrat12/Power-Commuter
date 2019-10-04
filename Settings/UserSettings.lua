local UserSettings = {}

UserSettings.SAVE_VESION = 1

-- Initialze Defaults
local serializedData = 
{
    JumpShortcuts = {}
}

UserSettings.JumpShortcuts = nil

function UserSettings.Initialize()
    -- Initialize serialized data
    serializedData = ZO_SavedVars:New("PowerCommuter_SavedVariables", 
                                         UserSettings.SAVE_VESION, "", 
                                         serializedData, nil)

    -- Assign refereces to data                                     
    PowerCommuter.UserSettings.JumpShortcuts.Data = serializedData.JumpShortcuts
end

PowerCommuter.UserSettings = UserSettings