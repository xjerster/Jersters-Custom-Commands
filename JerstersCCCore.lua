-- JerstersCC.lua

-- Initialize JerstersCC table
JerstersCC = JerstersCC or {}
JerstersCC.commands = JerstersCC.commands or {}

-- Generic function to register slash commands
function JerstersCC:RegisterSlashCommand(slashCmd, handler, description, parameters)
    _G["SLASH_" .. slashCmd .. "1"] = "/" .. slashCmd:lower()
    SlashCmdList[slashCmd] = handler
    -- Store command info for help menu
    self.commands[slashCmd] = {
        description = description or "No description available.",
        parameters = parameters or ""
    }
end

-- Slash command for the help menu
SLASH_JERSTERSCC1 = "/JerstersCC"
SlashCmdList["JERSTERSCC"] = function(msg)
    if msg:lower() == "menu" then
        -- Display help menu
        print("|cff00ff00JerstersCC Help Menu:|r")
        if next(JerstersCC.commands) == nil then
            print("No commands available.")
        else
            print("Available commands:")
            for cmd, info in pairs(JerstersCC.commands) do
                print("  /" .. cmd:lower() .. " " .. info.parameters .. " - " .. info.description)
            end
        end
    else
        print("|cff00ff00JerstersCC:|r Use /JerstersCC menu to see available commands.")
    end
end
