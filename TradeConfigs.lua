
-- Configuration table for Darnassus gift collection trade items
local DarnassusConfig = {
    items = {
        {name = "Handmade Woodcraft", stackSize = 5}, -- Per-item stack size
        {name = "Pledge of Loyalty: Darnassus", stackSize = 5},
        {name = "Sentinel's Card", stackSize = 5}
    },
    stacksToTrade = 1,
    validStacks = {1, 2, 3, 4}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Darnassus gift collection trade items"
}

-- Configuration table for Stormwind gift collection trade items
local StormwindConfig = {
    items = {
        {name = "Stormwind Guard's Card", stackSize = 5}, -- Per-item stack size
        {name = "Homemade Bread", stackSize = 5},
        {name = "Pledge of Loyalty: Stormwind", stackSize = 5}
    },
    stacksToTrade = 1,
    validStacks = {1, 2, 3, 4}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Stormwind gift collection trade items"
}

-- Configuration table for Scropok
local ScorpokConfig = {
    items = {
        {name = "Scorpok Pincer", stackSize = 3}, -- Per-item stack size
        {name = "Blasted Boar Lung", stackSize = 1},
        {name = "Vulture Gizzard", stackSize = 2}
    },
    stacksToTrade = 1,
    validStacks = {1, 2, 3, 4, 5, 6}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Salt of the Scorpok quest materials"
}

-- Configuration table for ROIDS
local ROIDSConfig = {
    items = {
        {name = "Scorpok Pincer", stackSize = 1}, -- Per-item stack size
        {name = "Blasted Boar Lung", stackSize = 2},
        {name = "Snickerfang Jowl", stackSize = 3}
    },
    stacksToTrade = 1,
    validStacks = {1, 2, 3, 4, 5, 6}, -- Allowed # of stacks to trade.
    helpText = "Automates trading R.O.I.D.S. quest materials"
}

-- Configuration table for Gizzard Gum
local GizzardConfig = {
    items = {
        {name = "Vulture Gizzard", stackSize = 10}, -- Per-item stack size
        {name = "Snickerfang Jowl", stackSize = 2}
    },
    stacksToTrade = 1,
    validStacks = {1, 2,}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Gizzard Gum quest materials"
}

-- Configuration table for Infallible Mind
local MindConfig = {
    items = {
        {name = "Basilisk Brains", stackSize = 10}, -- Per-item stack size
        {name = "Vulture Gizzard", stackSize = 2}
    },
    stacksToTrade = 1,
    validStacks = {1, 2,}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Infallible Mind quest materials"
}

-- Register slash commands
TradeItems:RegisterSlashCommand("JCCDARNBUFF", DarnassusConfig)
TradeItems:RegisterSlashCommand("JCCSWBUFF", StormwindConfig)
TradeItems:RegisterSlashCommand("JCCSCORPOK", ScorpokConfig)
TradeItems:RegisterSlashCommand("JCCROIDS", ROIDSConfig)
TradeItems:RegisterSlashCommand("JCCGUM", GizzardConfig)
TradeItems:RegisterSlashCommand("JCCMIND", MindConfig)
-- Register /JCCTrade
TradeItems:RegisterCustomTradeCommand("JCCTRADE")