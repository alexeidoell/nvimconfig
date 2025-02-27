return {
{
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

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
        ['<C-j>'] = { 'select_next', 'fallback' },
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
        }
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
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufRead",
    opts = {
        -- A list of parser names, or "all"
        ensure_installed = { "vimdoc", "c", "lua", "cpp", },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
},
{
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    opts = {},
},

{
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    event = "BufRead",
    dependencies =
    {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},

    },
    opts = function()
        require("nvim-treesitter").setup()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}

            vim.keymap.set("n", "<C-d>", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "<C-i>", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

        end)

        -- i hate when colors change when highlighting with cursor so
        -- just disabled all of it
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', {link="LspReferenceText"})
        vim.api.nvim_set_hl(0, 'LspReferenceText', {})

        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        require('mason').setup({})
        require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    clangd = function()
                        require('lspconfig').clangd.setup({
                            cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
                            init_options = {
                                fallbackFlags = {'I.', '-Wall', '-pedantic'}
                            },
                        })
                    end
                }
            })

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig['lua_ls'].setup({ capabilities = capabilities })

            -- this is the function that loads the extra snippets to luasnip
            -- from rafamadriz/friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },
    {
        'NMAC427/guess-indent.nvim',
        lazy = true,
        event = "BufRead",
    },
}
