return {
    {
        "folke/persistence.nvim",
        lazy = false,
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = function()
            local harpoon = require("harpoon")

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        lazy = true,
        ft = {
            "markdown",
        },
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
            require('leap').opts.vim_opts['go.ignorecase'] = true
            require('leap').opts.preview = true
            vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
            vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
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
{
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<leader>k", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<leader>j", function() mc.lineAddCursor(1) end)
        set({"n", "x"}, "<leader><leader>k", function() mc.lineSkipCursor(-1) end)
        set({"n", "x"}, "<leader><leader>j", function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
        set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)
        set("n", "<c-leftdrag>", mc.handleMouseDrag)
        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({"n", "x"}, "<c-q>", mc.toggleCursor)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<leader>h", mc.prevCursor)
            layerSet({"n", "x"}, "<leader>l", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
},
--- cringe vim plugins...
{
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
},
{
    "tpope/vim-fugitive",
    lazy = false,
},
{
    "yutkat/confirm-quit.nvim",
    lazy = true,
    opts = {
        overwrite_q_command = false,
    },
},
}
