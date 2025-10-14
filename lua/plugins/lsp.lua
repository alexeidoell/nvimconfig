return {
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        lazy = true,
        event = "InsertEnter",
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',
        build = 'cargo build --release',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-e: Hide menu
            -- C-k: Toggle signature help
            --
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                ['<C-h>'] = { 'show', 'hide' },
                ['<C-l>'] = { 'select_and_accept' },

                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'show', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
            },

            completion = {
                menu = {
                    draw = {
                        columns = { { "label", "label_description" }, { "kind" } },
                    }
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true
                    }
                },
            },


            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
        dependencies =
        {
            { 'williamboman/mason-lspconfig.nvim' },
            { 'L3MON4D3/LuaSnip' },
        },
        event = "BufReadPre",
        config = function()
            -- doing it like this lets me lazily load all lsp configuration 
            -- but I feel like there has gotta be a better way
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "clangd",
                    "emmylua_ls",
                    "jdtls",
                }
            })

            require("config.lspconfig")

            -- this is the function that loads the extra snippets to luasnip
            -- from rafamadriz/friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()
        end,

    },
}
