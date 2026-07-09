local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({{
            "Failed to clone lazy.nvim:\n" .. out, "Error"
        }}, true, {})
    end
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "yorumi" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
