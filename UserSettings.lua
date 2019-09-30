local UserSettings = {}

UserSettings.SAVE_VESION = 1

-- Initialze Defaults
local SerializedData = 
{
    KeyBindings = {}
}

UserSettings.KeyBindings = nil

function UserSettings.Initialize()
    SerializedData = ZO_SavedVars:New("PowerCommuter_SavedVariables", 
                                         UserSettings.SAVE_VESION, "", 
                                         SerializedData, nil)

UserSettings.KeyBindings = SerializedData.KeyBindings
end

PowerCommuter.UserSettings = UserSettings