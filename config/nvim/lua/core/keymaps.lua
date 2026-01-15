local opts = { silent = true }
local map = vim.keymap.set -- set new key mapping
local cmd = vim.cmd -- execute vimscript commands

-- Quarto preview
-- local quarto = require('quarto')
-- quarto.setup()
-- map('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true })

-- Jira
-- https://github.com/kid-icarus/jira.nvim did not work - looks like it used the HTTP api which I've not gotten to work
-- map('n', '<leader>jv', '<cmd>Jira issue view<cr>', {})
-- map('n', '<leader>jc', '<cmd>Jira issue create<cr>', {})
-- map('n', '<leader>jt', require("jira.pickers.telescope").transitions, {}) -- Telescope
-- map('n', '<leader>jt', require("jira.pickers.snacks").transitions, {}) -- Snacks


-- Lazygit opening files in neovim! https://github.com/kdheepak/lazygit.nvim/issues/22
-- local Util = require("lazyvim.util")
--
-- -- Function to check clipboard with retries
-- local function getRelativeFilepath(retries, delay)
--   local relative_filepath
--   for i = 1, retries do
--     relative_filepath = vim.fn.getreg("+")
--     if relative_filepath ~= "" then
--       return relative_filepath -- Return filepath if clipboard is not empty
--     end
--     vim.loop.sleep(delay) -- Wait before retrying
--   end
--   return nil -- Return nil if clipboard is still empty after retries
-- end
--
-- -- Function to handle editing from Lazygit
-- function LazygitEdit(original_buffer)
--   local current_bufnr = vim.fn.bufnr("%")
--   local channel_id = vim.fn.getbufvar(current_bufnr, "terminal_job_id")
--
--   if not channel_id then
--     vim.notify("No terminal job ID found.", vim.log.levels.ERROR)
--     return
--   end
--
--   vim.fn.chansend(channel_id, "\15") -- \15 is <c-o>
--   vim.cmd("close") -- Close Lazygit
--
--   local relative_filepath = getRelativeFilepath(5, 50)
--   if not relative_filepath then
--     vim.notify("Clipboard is empty or invalid.", vim.log.levels.ERROR)
--     return
--   end
--
--   local winid = vim.fn.bufwinid(original_buffer)
--
--   if winid == -1 then
--     vim.notify("Could not find the original window.", vim.log.levels.ERROR)
--     return
--   end
--
--   vim.fn.win_gotoid(winid)
--   vim.cmd("e " .. relative_filepath)
-- end
--
-- -- Function to start Lazygit in a floating terminal
-- function StartLazygit()
--   local current_buffer = vim.api.nvim_get_current_buf()
--   local float_term = Util.terminal.open({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
--
--   vim.api.nvim_buf_set_keymap(
--     float_term.buf,
--     "t",
--     "<c-e>",
--     string.format([[<Cmd>lua LazygitEdit(%d)<CR>]], current_buffer),
--     { noremap = true, silent = true }
--   )
-- end
--
-- map("n", "<leader>gg", [[<Cmd>lua StartLazygit()<CR>]], { noremap = true, silent = true })
-- Old lazygit simple
map("n", "<leader>gg", "<cmd>LazyGit<CR>", {desc = "Open lazygit"})

-- CodeCompanion
map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
map({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
cmd([[cab cc CodeCompanion]])

-- Open files in Chrome
-- :lua vim.ui.open(vim.fn.expand('%'))  also works but for default browser
map("n", "<leader>fx", '<cmd>!google-chrome "%"<cr>', { desc = "Open file in Chrome" })

-- Allow to save files as sudo (even if Neovim started without sudo)
map("c", "w!!", "w !sudo tee > /dev/null %", { desc = "Sudo write" })

-- Enter select mode from insert mode (useful for jumping between snippet nodes)
map("i", "<M-g>", "<Esc>gh", { desc = "Insert mode --> select mode" })

-- Add OSCYank for remote yanking
map('n', '<leader>y', '<Plug>OSCYankOperator')
map('n', '<leader>yy', '<leader>c_', {remap = true})
map('v', '<leader>y', '<Plug>OSCYankVisual')

-- Escape terminal emulator
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Escape terminal" })

-- Create new empty buffer
map("n", "<leader>fn", "<cmd>enew<CR>", opts)

-- Quick naviation to upper directory, nice for telescope
map("n", "<leader>.", "<cmd>cd ..<CR>", { desc = "Runs cd .. and changes directory" })

-- Better tabbing
map("v", "<", "<gv", { desc = "Unindent line", silent = true })
map("v", ">", ">gv", { desc = "Indent line", silent = true })

-- Navigate buffers
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer tab" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer tab" })
map("n", ">b", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer tab right" })
map("n", "<b", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer tab left" })

-- Bufdelete
map("n", "<leader>c", "<cmd>Bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>q", "<cmd>Bwipeout<CR>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>w|%bd|e#<cr>", {desc="Close all buffers but the current one"}) -- https://stackoverflow.com/a/42071865/516188

-- NeoTree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Focus Explorer" })

-- Git Signs
map("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
map("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
map("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>", { desc = "View git blame" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
map("n", "<leader>gh", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset git buffer" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage git hunk" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Unstage git hunk" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", { desc = "View git diff" })

-- Toggle Term
map("n", "<C-t>", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminal windows", silent = true })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "ToggleTerm float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm horizontal split" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "ToggleTerm vertical split" })
map("n", "<leader>tp", "<cmd>lua require('core.utils'):toggle_term_cmd('python')<CR>", { desc = "ToggleTerm python" })
map("n", "<leader>tn", "<cmd>lua require('core.utils'):toggle_term_cmd('node')<CR>", { desc = "ToggleTerm node" })
map("n", "<leader>vv", "<cmd>TermExec cmd='vale %' direction=float<CR>", { desc = "ToggleTerm node" })

-- Telescope
map(
  "n",
  "<leader>fd",
  "<cmd>lua require('telescope.builtin').find_files({prompt_title='Dotfiles', cwd='$HOME/.dotfiles'})<CR>",
  { desc = "Search dotfiles" }
)
map(
  "n",
  "<leader>fc",
  "<cmd>lua require('telescope.builtin').lsp_document_symbols({show_line=true})<CR>",
  { desc = "Search symbols and show line" }
)
map("n", "{", "<cmd>AerialPrev<CR>", { desc = "" })
map("n", "}", "<cmd>AerialNext<CR>", { desc = "" })
map("n", "<leader>aa", "<cmd>AerialToggle!<CR>", { desc = "" })
map("n", "<leader>rr", "<cmd>Telescope resume<CR>", { desc = "Resume the last picker" })
map("n", "<leader>fg", "<cmd>Telescope live_grep_args<CR>", { desc = "Search grep" })
map("n", "<leader>fa", "<cmd>Telescope live_grep_args hidden=true no_ignore=true<CR>", { desc = "Search grep including hidden/ignored" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Grep string under cursor" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Search files" })
map("n", "<leader>fh", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", { desc = "Search files including hidden/ignored" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Search buffers" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Search marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Search old files" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Search help" })
map("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Search man" })
map("n", "<leader>sr", "<cmd>Telescope registers<CR>", { desc = "Search registers" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" })
map("n", "<leader>sc", "<cmd>Telescope commands<CR>", { desc = "Search commands" })
map("n", "<leader>bd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer diagnostics" })
map("n", "<leader>wd", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>vd", vim.diagnostic.open_float, { desc = "View diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic previous" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic next" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy search in current buffer" })

cmd(":command -nargs=+ Rg :lua require('telescope.builtin').grep_string({search = <q-args>})<CR>")

-- Builtin LSP
map(
    "n",
    "<leader>de",
    function() vim.diagnostic.open_float({ focusable = true }) end,
    { desc = "Expand/focus/toggle an LSP Error / diagnostic into a float for copying" }
)
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP information" })
map("n", "<leader>lI", "<cmd>Mason<CR>", { desc = "LSP installer" })

-- Improved terminal mappings
map("t", "<C-h>", "<C-\\><C-n><C-W>h", { desc = "Terminal left window navigation", silent = true })
map("t", "<C-j>", "<C-\\><C-n><C-W>j", { desc = "Terminal down window navigation", silent = true })
map("t", "<C-k>", "<C-\\><C-n><C-W>k", { desc = "Terminal up window navigation", silent = true })
map("t", "<C-l>", "<C-\\><C-n><C-W>l", { desc = "Terminal right window naviation", silent = true })
map("t", "<C-t>", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminal windows", silent = true })

-- Debugger
local core_utils = require("core.utils")
if core_utils.is_plugin_available("nvim-dap") then
  map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Debugger: Start/Continue" })
  map("n", "<leader>dq", "<cmd>DapTerminate<CR>", { desc = "Debugger: Terminate" })
  map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Debugger: Toggle breakpoint" })
  map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Debugger: Step into" })
  map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Debugger: Step over" })
  map("n", "<leader>dO", "<cmd>DapStepOut<CR>", { desc = "Debugger: Step out" })
  map("n", "<leader>dr", "<cmd>DapRestartFrame<CR>", { desc = "Debugger: Restart frame" })

  map("n", "<leader>dR", function()
    require("dap").restart()
  end, { desc = "Debugger: Restart session" })
  map("n", "<leader>dC", function()
    vim.ui.input({ prompt = "Condition: " }, function(condition)
      if condition then
        require("dap").set_breakpoint(condition)
      end
    end)
  end, { desc = "Debugger: Set conditional breakpoint" })
  map("n", "<leader>dB", function()
    require("dap").clear_breakpoints()
  end, { desc = "Debugger: Clear all breakpoints" })

  if core_utils.is_plugin_available("nvim-dap-ui") then
    map("n", "<leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "Debugger: Hover over" })
    map("n", "<leader>dv", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end, { desc = "Debugger: View variables in the current scopes" })
  end
end
