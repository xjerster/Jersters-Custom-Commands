
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

-- Toggle Minimap Player Arrow
isArrowEnabled = true 

local function toggleMiniArrow()
    local defaultArrow = "Interface\\Minimap\\MinimapArrow"
    if isArrowEnabled then
        Minimap:SetPlayerTexture("")
        isArrowEnabled = false
    else
        Minimap:SetPlayerTexture(defaultArrow)
        isArrowEnabled = true
    end
end

-- Generic Crafting Slash Command
local function craftItem(msg)
    local normalizedMsg
    if msg:match("|Hitem") then
        local link, count = msg:match("^(.-)%s")
        local itemName = link and C_Item.GetItemInfoInstant(link) or msg
        normalizedMsg = itemName
    else
        itemName = msg
    end
    for i=1, GetNumTradeSkills() do 
        if GetTradeSkillInfo(i)==itemName then 
            DoTradeSkill(i,(select(3,GetTradeSkillInfo(i)))) 
        end
    end
end

-- Mooncloth Slash Command
local function craftMooncloth()
    CastSpellByName("Tailoring")
    local itemName = "Mooncloth"
    for i=1, GetNumTradeSkills() do 
        if GetTradeSkillInfo(i)==itemName then 
            DoTradeSkill(i,(select(3,GetTradeSkillInfo(i)))) 
        end
    end
end

-- Arcanite Slash Command
local function craftArcanite()
    CastSpellByName("Alchemy")
    local itemName = "Transmute: Arcanite"
    for i=1, GetNumTradeSkills() do 
        if GetTradeSkillInfo(i)==itemName then 
            DoTradeSkill(i,(select(3,GetTradeSkillInfo(i)))) 
        end
    end
end

-- Arcanite Slash Command
local function craftBandage()
    CastSpellByName("First Aid")
    local itemName = "Heavy Runecloth Bandage"
    for i=1, GetNumTradeSkills() do 
        if GetTradeSkillInfo(i)==itemName then 
            DoTradeSkill(i,(select(3,GetTradeSkillInfo(i))), 20) 
        end
    end
end

-- RegisterSlashCommands
JerstersCC:RegisterSlashCommand("JCCTOGC2M", clickToWalk, "Toggles Click-to-Move mode.", "", "Utility")
JerstersCC:RegisterSlashCommand("JCCTOGPPL", peopleBeGone, "Toggles Visibility of Players.", "", "Utility" )
JerstersCC:RegisterSlashCommand("JCCTOGMAPA", toggleMiniArrow, "Toggles Player's Minimap Arrow.", "", "Utility" )
JerstersCC:RegisterSlashCommand("JCCCRAFT", craftItem, "Crafts a given item *Tradeskill Window must be open.", "", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCRAFTMOONCLOTH", craftMooncloth, "Creats Mooncloth.", "", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCRAFTARCANITE", craftArcanite, "Transmutes Arcanite.", "", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCRAFTBANDAGE", craftBandage, "Attempts to Craft 20 Heavy Runcloth Bandages.", "", "Crafting" )
