vim.api.nvim_create_autocmd("FileType", {
  desc = "set errorformat for c file",
  pattern = "c",
  group = vim.api.nvim_create_augroup('c-errorformat', { clear = true }),
  callback = function()
    vim.opt_local.errorformat = '%f:%l:%c: %t%*[^:]: %m'
  end,
})

local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}

-- See https://github.com/MaskRay/ccls and https://github.com/MaskRay/ccls/wiki for ccls setup.
--
-- ccls minimal project setup with cmake:
-- launch the following commands in the project root directory,
-- they generate compile_commands.json file.
--
-- $ cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
-- $ ln -s Debug/compile_commands.json .
--
-- Optionally, use a .ccls file to enhance the configuration options from compile_commands.json
