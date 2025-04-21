
-- Toggle Click-to-Move using CVar
local function clickToWalk()
    if InCombatLockdown() then
        print("Cannot toggle Click-to-Move in combat.")
        return
    end
    local current = GetCVar("autointeract")
    SetCVar("autointeract", current == "1" and "0" or "1")
    print("Click-to-Move " .. (current == "1" and "disabled" or "enabled") .. ".")
end

-- Set character visablity
local function peopleBeGone()
    local currentTexLoadLimit = GetCVar("componentTexLoadLimit") 
    local currentTextureResolution = GetCVar("graphicsTextureResolution")
    SetCVar("componentTexLoadLimit", currentTexLoadLimit == "6" and "0" or "6")
    SetCVar("graphicsTextureResolution", currentTextureResolution == "1" and "0" or "1")
    print("Players " .. (currentTextureResolution == "1" and "shown" or "hidden") .. ".")
end

JerstersCC:RegisterSlashCommand("JCCTOGC2M", clickToWalk, "Toggles Click-to-Move mode.", "", "Utility")
JerstersCC:RegisterSlashCommand("JCCTOGPPL", peopleBeGone, "Toggles Visibility of Players.", "", "Utility" )