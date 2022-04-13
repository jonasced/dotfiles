local M = {}

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap -- set global key mapping
local cmd = vim.cmd -- call vimscript commands from Lua config

-- Allow to save files as sudo (even if Neovim started without sudo)
map("c", "w!!", "w !sudo tee > /dev/null %", opts)

-- Escape terminal emulator
map("t", "<C-q>", "<C-\\><C-n>", opts)

-- Highlights
map("n", "<leader><Space>", "<cmd>set hlsearch!<CR>", opts)

-- Better tabbing
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Nvim Tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
map("n", "<M-n>", ":NvimTreeFindFile<CR>", opts)

-- Git Signs
map("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", opts)
map("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", opts)
map("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>", opts)
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>gh", "<cmd>Gitsigns reset_hunk<CR>", opts)
map("n", "<leader>gr", "<cmd>Gitsigns reset_buffer<CR>", opts)
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", opts)

-- Toggle Term
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", opts)
map("n", "<leader>gg", "<cmd>lua require('core.utils').toggle_term_cmd('lazygit')<CR>", opts)
map("n", "<leader>tp", "<cmd>lua require('core.utils').toggle_term_cmd('python')<CR>", opts)

-- Telescope
map("n", "<leader>fd", "<cmd>lua require('telescope.builtin').find_files({prompt_title='VimRC', cwd='$HOME/.config/nvim'})<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", opts)
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts)
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", opts)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", opts)
map("n", "<leader>sn", "<cmd>Telescope notify<CR>", opts)
map("n", "<leader>sr", "<cmd>Telescope registers<CR>", opts)
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", opts)
map("n", "<leader>sc", "<cmd>Telescope commands<CR>", opts)
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts)
map("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)
cmd(":command -nargs=+ Rg :lua require('telescope.builtin').grep_string({search = <q-args>})<CR>")

return M
