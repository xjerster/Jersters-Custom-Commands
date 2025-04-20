
-- Configuration table for Darnassus trade items
local DarnassusConfig = {
    items = {
        {name = "Handmade Woodcraft", stackSize = 5}, -- Per-item stack size
        {name = "Pledge of Loyalty: Darnassus", stackSize = 5},
        {name = "Sentinel's Card", stackSize = 5}
    },
    stacksToTrade = 1,
    validStacks = {1, 2, 3, 4}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Darnassus Friendship materials"
}

-- Configuration table for Scropok
local ScorpokConfig = {
    items = {
        {name = "Scorpok Pincer", stackSize = 3}, -- Per-item stack size
        {name = "Blasted Boar Lung", stackSize = 1},
        {name = "Vulture Gizzard", stackSize = 2}
    },
    stacksToTrade = 1,
    validStacks = {1, 2, 3, 4}, -- Allowed # of stacks to trade.
    helpText = "Automates trading Salt of the Scorpok materials"
}

-- Register slash commands
TradeItems:RegisterSlashCommand("TRADEDARNASSUSFRIEND", DarnassusConfig)
TradeItems:RegisterSlashCommand("TRADESCORPOK", ScorpokConfig)
