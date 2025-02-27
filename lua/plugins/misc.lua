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
        event = "BufReadPre",
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
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            heading = {
                position = 'inline',
                icons = { '', '' },
                width = 'block',
                min_width = 80,
            },
            code =  {
                width = 'block',
                min_width = 80,
            },
            pipe_table = {
                filler = 'Character',
            },
            dash = {
                width = 80,
            },
            link = {
                image = '',
                email = '',
                hyperlink = '',
                wiki = '',
                custom = {
                    web = { pattern = '^http', icon = '', },
                },
            },
        },
    },
    {
        "ggandor/leap.nvim",
        opts = function()
            require('leap').create_default_mappings()
            require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

            -- Use the traversal keys to repeat the previous motion without
            -- explicitly invoking Leap:
            require('leap.user').set_repeat_keys('<enter>', '<backspace>')

            -- Define a preview filter (skip the middle of alphanumeric words):
            require('leap').opts.preview_filter =
            function (ch0, ch1, ch2)
                return not (
                    ch1:match('%s') or
                    ch0:match('%w') and ch1:match('%w') and ch2:match('%w')
                )
            end
        end
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
