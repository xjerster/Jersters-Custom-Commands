-- Configuration table for trade items
local TradeConfig = {
    items = {"Handmade Woodcraft", "Pledge of Loyalty: Darnassus", "Sentinel's Card"},
    stackSize = 5, -- Default stack size
    stacksToTrade = 1,
    tradeTimeout = 5, -- Seconds to wait for stack creation
    validStackSizes = {5, 10, 15, 20} -- Allowed stack sizes
}

-- Slash command setup
SLASH_TRADEDARNASSUSFRIEND1 = "/tradedarnassusfriend"
SlashCmdList["TRADEDARNASSUSFRIEND"] = function(msg)
    local stackSize = tonumber(msg) -- Convert input to number
    if stackSize then
        -- Check if the input is a valid stack size
        for _, size in ipairs(TradeConfig.validStackSizes) do
            if stackSize == size then
                TradeConfig.stackSize = stackSize
                TradeItems:StartTrade()
                return
            end
        end
        TradeItems:Error("Invalid stack size. Use 5, 10, 15, or 20.")
    else
        -- No argument provided, use default
        TradeConfig.stackSize = 5
        TradeItems:StartTrade()
    end
end
