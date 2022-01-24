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

-- local null_ls_status_ok, null_ls = pcall(require, "null-ls")
-- if not null_ls_status_ok then
-- 	return
-- end

-- local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
--
-- null_ls.setup({
-- 	debug = false,
-- 	sources = {
-- 		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
-- 		formatting.black.with({ extra_args = { "--fast" } }),
-- 		formatting.stylua,
-- 	},
-- })

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
