return {
    {
        "copilotlsp-nvim/copilot-lsp",
        event = "BufEnter",
        opts = function()
            vim.g.copilot_nes_debounce = 500
        vim.lsp.config("copilot", {
            on_init = function(client)
                vim.api.nvim_set_hl(0, "NesAdd", { link = "DiffAdd", default = true })
                vim.api.nvim_set_hl(0, "NesDelete", { link = "DiffDelete", default = true })
                vim.api.nvim_set_hl(0, "NesApply", { link = "DiffText", default = true })

                local au = vim.api.nvim_create_augroup("copilot-language-server", { clear = true })

                --NOTE: didFocus
                vim.api.nvim_create_autocmd("BufEnter", {
                    callback = function()
                        local td_params = vim.lsp.util.make_text_document_params()
                        client:notify("textDocument/didFocus", {
                            textDocument = {
                                uri = td_params.uri,
                            },
                        })
                    end,
                    group = au,
                })

                vim.keymap.set("n", "<leader>rn", function()
                    require("copilot-lsp.nes").request_nes(client)
                end)
            end,
        })
            vim.lsp.enable("copilot_ls")
            vim.keymap.set("n", "<C-l>", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local state = vim.b[bufnr].nes_state
                if state then
                    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                    or (
                        require("copilot-lsp.nes").apply_pending_nes()
                        and require("copilot-lsp.nes").walk_cursor_end_edit()
                    )
                    return nil
                else
                    return "<C-l>"
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })
        end,
    },
}
