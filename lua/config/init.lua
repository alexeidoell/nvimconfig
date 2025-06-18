require("config.set")
require("config.remap")


vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "no"
vim.opt.cmdheight = 0


-- idk why i have to do this, but otherwise snacks picker and session don't
-- detect the filetype properly
vim.api.nvim_create_autocmd({"BufReadPre"}, {
    command = "filetype detect"
})

