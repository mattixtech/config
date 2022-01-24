local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {"dockerfile", "rust", "lua", "json", "yaml", "markdown", "php", "fish", "bash", "toml", "regex", "make" },
  sync_install = false,
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = false },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

require('spellsitter').setup({
    enabled = true,
})
