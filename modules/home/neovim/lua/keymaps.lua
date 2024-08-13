-- [[ Keymap Configuration ]] ------------------------------------------
-- This file contains the keymap configuration for the neovim editor.
-- See `:help vim.keymap.set()` for more information.
------------------------------------------------------------------------

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Use `<Esc><Esc> to exit terminal mode.`
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffer management
vim.keymap.set("n", "bn", ":<cmd>bnext<cr><cr>", { desc = 'Next buffer' })
vim.keymap.set("n", "bN", ":<cmd>bprev<cr><cr>", { desc = 'Previous buffer' })
vim.keymap.set("n", "bp", ":<cmd>bprev<cr><cr>", { desc = 'Previous buffer' })
vim.keymap.set("n", "bP", ":<cmd>bnext<cr><cr>", { desc = 'Next buffer' })
vim.keymap.set("n", "bq", ":<cmd>bd<cr><cr>",    { desc = 'Close buffer' })

-- [[ Basic Autocommands ]] --------------------------------------------
-- This section contains basic autocommands for the neovim editor, which
-- are used to trigger events based on certain actions.
--  See `:help lua-guide-autocommands`
------------------------------------------------------------------------

-- Highlight when yanking (copying) text, see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to last position in previously opened file
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last position in previously opened file, if exists.",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})

-- Force transparent BG
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Force transparent BG when entering files, in case config didn't set properly.",
  command = [[ hi Normal guibg=NONE ctermbg=NONE ]]
})
