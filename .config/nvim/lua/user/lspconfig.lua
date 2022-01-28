local lspsetup = require("user.lspsetup")

local nvim_lsp = require('lspconfig')
lspsetup.setup()
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = lspsetup.on_attach,
    capabilities = lspsetup.capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local lspsaga = require "lspsaga"
lspsaga.setup({
    code_action_keys = {
      quit = "<Esc>",
      exec = "<CR>",
    },
    rename_action_keys = {
      quit = "<Esc>",
      exec = "<CR>",
    },
    finder_action_keys = {
      quit = "<Esc>",
    },
})
