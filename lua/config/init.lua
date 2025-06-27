require("config.set")
require("config.remap")


vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "no"
vim.opt.cmdheight = 0

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set("n", "<C-d>", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<C-i>", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

    -- i hate when colors change when highlighting with cursor so
    -- just disabled all of it
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = "LspReferenceText" })
    vim.api.nvim_set_hl(0, 'LspReferenceText', {})
end,
})

vim.lsp.enable({
    'emmylua_ls',
    'clangd',
    'lemminx',
    'rust_analyzer'
})

