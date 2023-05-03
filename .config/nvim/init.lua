vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- Spelling configuration
vim.opt.spell = false
vim.opt.spelllang = { "en_us", "en_ca" }

-- Netrw confifguration
vim.g.netrw_mkdir = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = 'noma nomod relativenumber nowrap ro nobl'

-- Autocommands
-- Terminal
vim.api.nvim_create_autocmd(
  { "TermOpen" },
  { pattern = "*", command = "setlocal nospell" }
)
vim.api.nvim_create_autocmd(
  { "TermOpen" },
  { pattern = "*", command = "startinsert" }
)
vim.api.nvim_create_autocmd(
  { "BufWinEnter", "WinEnter" },
  { pattern = "term://*", command = "startinsert" }
)
-- Spelling in source code
vim.api.nvim_create_autocmd(
  { "BufReadPost" },
  { pattern = { "*.rs", "*.md", "*.toml" }, command = "setlocal spell" }
)

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lazy_plugins = {
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'mbbill/undotree',
  'kevinhwang91/nvim-bqf',
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      -- 'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },
  { 'folke/which-key.nvim',          opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filename',
            path = 1,
            shorting_target = 60,
          },
        },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  { 'numToStr/Comment.nvim',         opts = {} },
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "simrat39/rust-tools.nvim"
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('crates').setup()
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim"
  },
}
require('lazy').setup(lazy_plugins, {})

-- [[ Theme Setup ]]
local modified_catppuccin = require('lualine.themes.catppuccin')
modified_catppuccin.normal.c.bg = 'None'
require('lualine').setup { options = { theme = modified_catppuccin } }
require("catppuccin").setup {
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.5,
  },
  integrations = {
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
}

-- [[ Setting options ]]
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.termguicolors = true
vim.o.scrolloff = 3
vim.o.sidscrolloff = 3

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension("ui-select")

-- [[ Configure Treesitter ]]
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'vim', 'toml', 'markdown', 'markdown_inline', 'json', 'yaml', 'rust', 'c', 'go', 'zig',
    'fish', 'bash', 'javascript', 'typescript' },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.type_definition, '[G]oto Type [D]efinition')
  nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementations')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
-- Setup neovim lua configuration
require('neodev').setup()
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Setup mason so it can manage external tooling
require('mason').setup()
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- diag
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  signs = { min = vim.diagnostic.severity.INFO },
  update_in_insert = false,
  underline = {
    severity = { min = vim.diagnostic.severity.WARN }
  },
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = 'none',
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer' },
  },
}
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- [[ Configure Rust Tools ]]
--
-- Filter only the current workspace for diagnostics
local function ensure_uri_scheme(uri)
  if not vim.startswith(uri, "file://") then
    return "file://" .. uri
  end
  return uri
end

local function is_in_workspace(uri)
  uri = ensure_uri_scheme(uri)
  local path = vim.uri_to_fname(uri)
  local workspace_dir = vim.fn.getcwd()

  return vim.startswith(path, workspace_dir)
end

local function filter_diagnostics(diagnostics)
  local filtered_diagnostics = {}
  for _, diagnostic in ipairs(diagnostics) do
    if is_in_workspace(diagnostic.source) then
      table.insert(filtered_diagnostics, diagnostic)
    end
  end
  return filtered_diagnostics
end

local rt = require("rust-tools")
local lspconfig = require('lspconfig')
rt.setup({
  tools = {
    autoSetHints = true,
    runnables = {
      use_telescope = true,
    },
    debuggables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
    hover_actions = {
      auto_focus = true,
    },
  },
  server = {
    root_dir = function(startpath)
      local startpath_uri = vim.uri_from_fname(startpath)
      if not is_in_workspace(startpath) then
        return nil
      end

      return lspconfig.util.root_pattern("Cargo.toml", "rust-project.json")(startpath)
    end,
    standalone = true,
    settings = {
      ["rust-analyzer"] = {
        check = {
          allFeatures = true,
          features = "all",
        },
        cargo = {
          allFeatures = true,
          features = "all",
        },
        checkOnSave = {
          command = "check",
        },
      },
    },
    on_attach = function(x, bufnr)
      vim.keymap.set("n", "<Leader>rg", rt.hover_actions.hover_actions, { desc = 'Rust Hover', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rm", rt.expand_macro.expand_macro, { desc = 'Expand [R]ust [M]acro', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rr", rt.runnables.runnables, { desc = '[R]ust [R]unnables', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rJ", rt.join_lines.join_lines, { desc = '[R]ust [J]oin Lines', buffer = bufnr })
      vim.keymap.set("n", "<Leader>ri", rt.inlay_hints.enable, { desc = '[R]ust [I]nlay hints on', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rI", rt.inlay_hints.disable, { desc = '[R]ust [I]nlay hints off', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rk", ":RustMoveItemUp<cr>", { desc = '[R]ust Move Item Up', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rj", ":RustMoveItemDown<cr>", { desc = '[R]ust Move Item Down', buffer = bufnr })
      vim.keymap.set("n", "<Leader>rf", ":!cargo fmt --quiet<cr>", { desc = '[R]ust [F]ormat', buffer = bufnr })
      on_attach(x, bufnr)
    end,
  },
})

-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", "<C-w><C-s>:Explore<CR>", { desc = 'E[X]plore Split', noremap = true, silent = true })
vim.keymap.set("n", "<leader>X", ":Explore<CR>", { desc = 'E[X]plore', noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", "<C-w><C-s>:terminal<CR>", { desc = '[T]erminal Split', noremap = true, silent = true })
vim.keymap.set("n", "<leader>T", ":terminal<CR>", { desc = '[T]erminal', noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", ":b#<CR>", { desc = 'Switch [B]uffer', noremap = true, silent = true })
-- Resize with arrows
vim.keymap.set("n", "<A-Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
-- -- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- Plugin keymaps
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>")
vim.keymap.set('n', '<leader>u', ":UndotreeToggle<cr>", { desc = '[U]ndo Tree' })
-- telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
  { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').git_status, { desc = '[S]earch Git [S]tatus' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').git_branches, { desc = '[S]earch Git [B]ranches' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').git_commits, { desc = '[S]earch Git [C]ommits' })
vim.keymap.set('n', '<leader>sC', require('telescope.builtin').git_bcommits, { desc = '[S]earch Git Buffer [C]ommits' })
-- git signs
vim.keymap.set('n', '<leader>gp', ":Gitsigns preview_hunk<cr>", { desc = '[G]it [P]review Hunk' })
vim.keymap.set('n', '<leader>gr', ":Gitsigns reset_hunk<cr>", { desc = '[G]it [R]eset Hunk' })
vim.keymap.set('n', '<leader>gl', ":Gitsigns next_hunk<cr>", { desc = '[G]it Next Hunk' })
vim.keymap.set('n', '<leader>gh', ":Gitsigns prev_hunk<cr>", { desc = '[G]it Previous Hunk' })
