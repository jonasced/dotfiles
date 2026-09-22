-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { silent = true }
local map = vim.keymap.set -- set new key mapping
local cmd = vim.cmd -- execute vimscript commands


-- Aerial
map("n", "{", "<cmd>AerialPrev<CR>", { desc = "" })
map("n", "}", "<cmd>AerialNext<CR>", { desc = "" })
map("n", "<leader>aa", "<cmd>AerialToggle!<CR>", { desc = "" })

-- Improved terminal mappings
map("t", "<C-h>", "<C-\\><C-n><C-W>h", { desc = "Terminal left window navigation", silent = true })
-- map("t", "<C-j>", "<C-\\><C-n><C-W>j", { desc = "Terminal down window navigation", silent = true })
-- map("t", "<C-k>", "<C-\\><C-n><C-W>k", { desc = "Terminal up window navigation", silent = true })
map("t", "<C-l>", "<C-\\><C-n><C-W>l", { desc = "Terminal right window naviation", silent = true })
map("t", "<C-t>", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminal windows", silent = true })
-- Escape terminal emulator
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Escape terminal" })
-- Toggle Term
map("n", "<C-t>", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminal windows", silent = true })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "ToggleTerm float" })
map("n", "<leader>ts", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm horizontal split" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "ToggleTerm vertical split" })
map("n", "<leader>tp", "<cmd>lua require('core.utils'):toggle_term_cmd('python')<CR>", { desc = "ToggleTerm python" })
