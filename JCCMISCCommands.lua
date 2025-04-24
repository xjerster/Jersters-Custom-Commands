
-- Toggle Click-to-Move using CVar
local function clickToWalk()
    if InCombatLockdown() then
        DEFAULT_CHAT_FRAME:AddMessage("Cannot toggle Click-to-Move in combat.")
        return
    end
    local current = GetCVar("autointeract")
    SetCVar("autointeract", current == "1" and "0" or "1")
    DEFAULT_CHAT_FRAME:AddMessage("Click-to-Move " .. (current == "1" and "disabled" or "enabled") .. ".")
end

-- Set character visablity
local function peopleBeGone()
    local currentTexLoadLimit = GetCVar("componentTexLoadLimit") 
    local currentTextureResolution = GetCVar("graphicsTextureResolution")
    SetCVar("componentTexLoadLimit", currentTexLoadLimit == "6" and "0" or "6")
    SetCVar("graphicsTextureResolution", currentTextureResolution == "1" and "0" or "1")
    DEFAULT_CHAT_FRAME:AddMessage("Players " .. (currentTextureResolution == "1" and "shown" or "hidden") .. ".")
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
    if not msg or msg == "" then
        print("Error: No item specified.")
        return
    end
    local normalizedMsg = ""
    if msg:match("|Hitem") then
        local link, count = msg:match("^(.-)%s*(%d*)$")
        local itemName = link and C_Item.GetItemInfo(link) or msg
        normalizedMsg = itemName .. " " .. (count or 1)
    else
        normalizedMsg = msg:gsub("%[", ""):gsub("%]", "")
    end
    local itemName, count = normalizedMsg:match("^(.-)%s*(%d*)$")
    count = tonumber(count) or 0
    for i = 1, GetNumTradeSkills() do
        local skillName = GetTradeSkillInfo(i)
        if skillName and skillName:lower() == itemName:lower() then
            -- Validate reagents and count
            local numAvailable = select(3, GetTradeSkillInfo(i)) or 0
            if count > numAvailable then
                print("Error: Innsuficent reagents. Supply:" .. numAvailable .. "Requested: " .. count)
                DoTradeSkill(i,(select(3,GetTradeSkillInfo(i))))
                return
            elseif count == 0 then
                DoTradeSkill(i,(select(3,GetTradeSkillInfo(i))))
                return
            end
            DoTradeSkill(i, count)
            return
        end
    end
    print("Error: Trade skill '" .. itemName .. "' not found.")
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

-- Bandage Slash Command
local function craftBandage()
    CastSpellByName("First Aid")
    local itemName = "Bandage"
    for i=1, GetNumTradeSkills() do 
        if string.match(GetTradeSkillInfo(i), itemName) then
            DoTradeSkill(i,(select(3,GetTradeSkillInfo(i))))  
        end
    end
end

local function currBuild()
    local interfaceVersion = select(4, GetBuildInfo())
    DEFAULT_CHAT_FRAME:AddMessage("|cff0070ddInterface Version:|r " .. interfaceVersion)
end

-- RegisterSlashCommands
JerstersCC:RegisterSlashCommand("JCCTOGC2M", clickToWalk, "Toggles Click-to-Move mode.", "", "Utility")
JerstersCC:RegisterSlashCommand("JCCTOGPPL", peopleBeGone, "Toggles Visibility of Players.", "", "Utility" )
JerstersCC:RegisterSlashCommand("JCCTOGMAPA", toggleMiniArrow, "Toggles Player's Minimap Arrow.", "", "Utility" )
JerstersCC:RegisterSlashCommand("JCCCRAFT", craftItem, "Crafts a given item *Tradeskill Window must be open.", "[Item Name] -Optional Count", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCRAFTMOONCLOTH", craftMooncloth, "Creats Mooncloth.", "", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCRAFTARCANITE", craftArcanite, "Transmutes Arcanite.", "", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCRAFTBANDAGE", craftBandage, "Craft All - Highest known bandage.", "", "Crafting" )
JerstersCC:RegisterSlashCommand("JCCCURBUILD", currBuild, "Displays current WOW build in the chat window.", "", "Utility" )

