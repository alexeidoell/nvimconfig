return {
        {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = "BufReadPre",
        config = function()
            -- A list of parser names, or "all"
            local configs = require("nvim-treesitter.configs")
            configs.setup({
            ensure_installed = { "vimdoc", "c", "lua", "cpp", "markdown", "rust", "xml", "regex" },

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
        })
        end,
        build = function()
            require("nvim-treesitter.install").update( { with_sync = true })
        end,
    },
    {
            "nvim-treesitter/nvim-treesitter-context",
            lazy = true,
            event = "BufReadPre",
    },
--[[
    {
        "VonHeikemen/lsp-zero.nvim",
        lazy = true,
        event = "BufRead",
        dependencies =
        {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },

        },
        opts = function()
            require("nvim-treesitter").setup()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

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
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = "LspReferenceText" })
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
                            cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
                            init_options = {
                                fallbackFlags = { 'I.', '-Wall', '-pedantic' }
                            },
                        })
                    end,
                }
            })

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig['lua_ls'].setup({ capabilities = capabilities })

            -- this is the function that loads the extra snippets to luasnip
            -- from rafamadriz/friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },]]--
    {
        'NMAC427/guess-indent.nvim',
        lazy = true,
        event = "BufRead",
    },
}
