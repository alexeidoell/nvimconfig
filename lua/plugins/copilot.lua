return {
    {
        "copilotlsp-nvim/copilot-lsp",
        opts = function()
            vim.g.copilot_nes_debounce = 500
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
                    return nil
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })
        end,
    },
}
