-- JerstersCC.lua

-- Initialize JerstersCC table
JerstersCC = JerstersCC or {}
JerstersCC.commands = JerstersCC.commands or {}

-- Generic function to register slash commands
function JerstersCC:RegisterSlashCommand(slashCmd, handler, description, parameters, category)
    _G["SLASH_" .. slashCmd .. "1"] = "/" .. slashCmd:lower()
    SlashCmdList[slashCmd] = handler
    -- Store command info for help menu
    self.commands[slashCmd] = {
        description = description or "No description available.",
        parameters = parameters or "",
        category = category or "General"
    }
end

-- Slash command for the help menu
SLASH_JERSTERSCC1 = "/JerstersCC"
SLASH_JERSTERSCC2 = "/JCC"
SlashCmdList["JERSTERSCC"] = function(msg)
    if msg:lower() == "menu" then
        -- Display help menu
        print("|cff0070ddJerstersCC Help Menu:|r")
        if next(JerstersCC.commands) == nil then
            print("No commands available.")
        else
            -- Group commands by category
            local categories = {}
            for cmd, info in pairs(JerstersCC.commands) do
                local cat = info.category
                categories[cat] = categories[cat] or {}
                table.insert(categories[cat], {cmd = cmd, info = info})
            end
            -- Display each category
            for cat, cmds in pairs(categories) do
                print("|cff00ff00" .. cat .. " Commands:|r")
                for _, entry in ipairs(cmds) do
                    print("  /" .. entry.cmd:lower() .. " " .. entry.info.parameters .. " - " .. entry.info.description)
                end
            end
        end
    else
        print("|cff0070ddJerstersCC:|r Use /JerstersCC menu to see available commands.")
    end
end
