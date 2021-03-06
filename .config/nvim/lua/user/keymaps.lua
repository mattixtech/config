local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader><leader>", ":edit #<cr>", opts)

-- Quick
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>q", ":q<cr>", opts)
keymap("n", "<leader>Q", ":%bd|e#<cr>", opts)
keymap("n", "<leader>c", ":Bdelete<cr>", opts)
keymap("n", "<leader>C", ":tabclose<cr>", opts)
keymap("n", "<leader>h", ":nohlsearch<cr>", opts)
keymap("n", "<leader>l", ":set list!<cr>", opts)
keymap("n", "<leader>s", ":set spell!<cr>", opts)
keymap("n", "<leader>o", ":only!<cr>", opts)
keymap("n", "<leader>O", ":tabonly!<cr>", opts)

-- Git
keymap("n", "<leader>gg", ":Git<cr>", opts)
keymap("n", "<leader>gb", ":Git blame<cr>", opts)
keymap("n", "<leader>gp", ":lua require 'gitsigns'.preview_hunk()<cr>", opts)
keymap("n", "<leader>gr", ":lua require 'gitsigns'.reset_hunk()<cr>", opts)
keymap("n", "<leader>gR", ":lua require 'gitsigns'.reset_buffer()<cr>", opts)
keymap("n", "<leader>gd", ":Gvdiffsplit<cr>", opts)

-- Search via Telescope
keymap("n", "<leader>tr", ":Telescope oldfiles previwer=false<cr>", opts)
keymap("n", "<leader>ts", ":Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>tS", ":Telescope lsp_dynamic_workspace_symbols<cr>", opts)
keymap("n", "<leader>tf", ":Telescope find_files previewer=false<cr>", opts)
keymap("n", "<leader>tF", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>tp", ":Telescope projects<cr>", opts)
keymap("n", "<leader>tk", ":Telescope keymaps<cr>", opts)
keymap("n", "<leader>tb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>tB", ":Telescope git_branches previewer=false<cr>", opts)
keymap("n", "<leader>tG", ":Telescope git_stash<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

