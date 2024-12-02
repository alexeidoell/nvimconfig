return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        opts = {
            dashboard = {
                width = 18,
                preset = {
                    keys = {
                        { icon = "", key = "e", desc = "explorer", action = "<CMD>Oil<CR>" },
                        { icon = "", key = "r", desc = "recent file", section = "session" },
                        { icon = "", key = "f", desc = "find file", action = ":lua Snacks.dashboard.pick('files')", },
                        { icon = "", key = "n", desc = "new file", action = ":ene | startinsert" },
                        { icon = "", key = "s", desc = "search text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = "", key = "c", desc = "config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
                        { icon = "", key = "l", desc= "lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = "", key = "q", desc = "quit", action = function()
                            require("confirm-quit").confirm_quit()
                        end, },
                    },
                    header = [[]],
                },
                formats = {
                    key = { "" },
                },
                sections = {
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup"},
                }
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
