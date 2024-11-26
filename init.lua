local path = vim.fn.stdpath("config") .. "/"
local out = vim.fn.system({ "git", "pull", path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone config:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1);
  end

require("config")
require("config.lazy")
