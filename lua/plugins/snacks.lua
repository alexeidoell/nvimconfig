return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            dashboard = {
                width = 18,
                preset = {
                    keys = {
                        { icon = "", key = "f", desc = "find file", action = ":lua Snacks.dashboard.pick('files')", },
                        { icon = "", key = "n", desc = "new file", action = ":ene | startinsert" },
                        { icon = "", key = "g", desc = "grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = "", key = "r", desc = "recent file", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = "", key = "c", desc = "config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
                        { icon = "", key = "s", desc = "session", section = "session" },
                        { icon = "", key = "L", desc= "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = "", key = "q", desc = "quit", action = function()
                            require("confirm-quit").confirm_quit()
                        end, },
                    },
                    header = [[]],
                },
                formats = {
                    key = { "" },
                },
            },
            notifier = { 
                style = "compact",
                icons = {
                    error = "",
                    warn = "",
                    info = "",
                    debug = "",
                    trace = "",
                },
            },
            words = { enabled = true },
        },
    }
}
