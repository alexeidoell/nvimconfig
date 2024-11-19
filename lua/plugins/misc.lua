return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},

    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "theprimeagen/harpoon",
        lazy = true,
        opts = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
        end,
    },
    --- cringe vim plugins...
    {
        "mbbill/undotree",
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "yutkat/confirm-quit.nvim",
        lazy = true,
        opts = {
            overwrite_q_command = false,
        },
    },
}
