-- TradeItems module
TradeItems = TradeItems or {}

-- Register a Slash Command for trading.
function TradeItems:RegisterSlashCommand(slashCmd, config)
    _G["SLASH_" .. slashCmd .. "1"] = "/" .. slashCmd:lower()
    local defaultStacksToTrade = config.stacksToTrade -- Store the default value
    SlashCmdList[slashCmd] = function(msg)
        local stacksToTrade = tonumber(msg) -- Convert input to number
        if stacksToTrade then
            -- Check if input is in validStacks
            for _, validStack in ipairs(config.validStacks) do
                if stacksToTrade == validStack then
                    config.stacksToTrade = stacksToTrade
                    self:StartTrade(config)
                    return
                end
            end
            self:Error("Invalid number of stacks. Use " .. table.concat(config.validStacks, ", ") .. ".")
        else
            -- No argument or invalid input, use default
            config.stacksToTrade = defaultStacksToTrade
            self:StartTrade(config)
        end
    end
end

-- Error handler
function TradeItems:Error(msg)
    print("|cffff0000TradeItems Error:|r " .. msg)
end

-- Check if trade window is open
function TradeItems:IsTradeWindowOpen()
    return TradeFrame and TradeFrame:IsShown()
end

-- Find a stack of the exact size in bags
function TradeItems:FindExactStack(itemName, stackSize)
    for bag = 0, NUM_BAG_SLOTS do
        local slots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, slots do
            local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID and itemInfo then
                local name = GetItemInfo(itemID)
                if name == itemName and itemInfo.stackCount == stackSize then
                    return bag, slot
                end
            end
        end
    end
    return nil, nil
end

-- Find an empty bag slot
function TradeItems:FindEmptySlot()
    for bag = 0, NUM_BAG_SLOTS do
        local slots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, slots do
            if not C_Container.GetContainerItemID(bag, slot) then
                return bag, slot
            end
        end
    end
    return nil, nil
end

-- Create a stack of the specified size
function TradeItems:CreateStack(itemName, stackSize, callback)
    local frame = CreateFrame("Frame")
    local waitTime = 5
    local targetBag, targetSlot

    -- Find a stack with enough items
    for bag = 0, NUM_BAG_SLOTS do
        local slots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, slots do
            local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID and itemInfo and itemInfo.stackCount >= stackSize then
                local name = GetItemInfo(itemID)
                if name == itemName then
                    targetBag, targetSlot = self:FindEmptySlot()
                    if not targetBag then
                        self:Error("No empty bag slots available.")
                        callback(nil, nil)
                        return
                    end
                    C_Container.SplitContainerItem(bag, slot, stackSize)
                    C_Container.PickupContainerItem(targetBag, targetSlot)
                    break
                end
            end
        end
        if targetBag then break end
    end

    if not targetBag then
        self:Error("Not enough " .. itemName .. " to create a stack of " .. stackSize .. ".")
        callback(nil, nil)
        return
    end

    -- Monitor stack creation
    frame:SetScript("OnUpdate", function(self, elapsed)
        waitTime = waitTime - elapsed
        if waitTime <= 0 then
            self:Hide()
            self:SetScript("OnUpdate", nil)
            self:UnregisterAllEvents()
            self:SetParent(nil)
            self = nil
            self:Error("Timed out creating stack of " .. itemName .. ".")
            ClearCursor()
            callback(nil, nil)
            return
        end

        local itemInfo = C_Container.GetContainerItemInfo(targetBag, targetSlot)
        local itemID = C_Container.GetContainerItemID(targetBag, targetSlot)
        local name = itemID and GetItemInfo(itemID) or nil
        if itemInfo and name == itemName and itemInfo.stackCount == stackSize then
            self:Hide()
            self:SetScript("OnUpdate", nil)
            self:UnregisterAllEvents()
            self:SetParent(nil)
            self = nil
            callback(targetBag, targetSlot)
        end
    end)
end

-- Get or create a stack and place it in the trade window
function TradeItems:GetStack(itemName, stackSize, tradeSlot, callback)
    local bag, slot = self:FindExactStack(itemName, stackSize)
    if bag and slot then
        C_Container.PickupContainerItem(bag, slot)
        ClickTradeButton(tradeSlot)
        callback(tradeSlot + 1)
    else
        self:CreateStack(itemName, stackSize, function(bag, slot)
            if bag and slot then
                C_Container.PickupContainerItem(bag, slot)
                ClickTradeButton(tradeSlot)
                callback(tradeSlot + 1)
            else
                callback(nil)
            end
        end)
    end
end

-- Start the trade process
function TradeItems:StartTrade(config)
    if not self:IsTradeWindowOpen() then
        self:Error("Please open a trade window first.")
        return
    end

    local tradeSlot = 1
    local function processItem(index)
        if index > #config.items then
            print("Trade setup complete.")
            return
        end

        local item = config.items[index]
        local totalQuantity = item.stackSize * config.stacksToTrade
        self:GetStack(item.name, totalQuantity, tradeSlot, function(nextSlot)
            if nextSlot then
                tradeSlot = nextSlot
                processItem(index + 1)
            else
                self:Error("Failed to process " .. item.name .. ".")
            end
        end)
    end

    processItem(1)
end

-- Helper function to register trade slash commands
function TradeItems:RegisterTradeSlashCommand(slashCmd, config)
    _G["SLASH_" .. slashCmd .. "1"] = "/" .. slashCmd:lower()
    SlashCmdList[slashCmd] = function(msg)
        local stacksToTrade = tonumber(msg) -- Convert input to number
        if stacksToTrade then
            -- Validate stacksToTrade against validStacks
            for _, validStack in pairs(config.validStacks) do
                if stacksToTrade == validStack then
                    config.stacksToTrade = stacksToTrade
                    self:StartTrade(config)
                    return
                end
            end
            self:Error("Invalid number of stacks. Use " .. table.concat(config.validStacks, ", ") .. ".")
        else
            -- No argument provided, use default
            self:StartTrade(config)
        end
    end
end