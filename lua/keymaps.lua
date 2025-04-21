-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--
-- pressing 'jk' in insert mode switches to normal mode
vim.keymap.set('i', 'jk', '<esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Toggle Terminal
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = '[T]erminal' })

-- Delete buffer with leader + Q
vim.keymap.set('n', '<leader>Q', ':bd<CR>', { desc = 'Close Buffer' })

-- Change directory to current file
vim.keymap.set('n', '<leader>cd', function()
    vim.cmd('cd ' .. vim.fn.expand '%:p:h')
    print('CWD set to ' .. vim.fn.getcwd())
end, { desc = '[C]hange [Directory] to current file directory' })

-- J (Down) Relative movements get added to jumplist you can return using ctrl + o
vim.keymap.set('n', 'j', function()
    if vim.v.count > 0 then
        return "m'" .. vim.v.count .. 'j'
    end
    return 'j'
end, { expr = true })

-- K (Up) Relative movements get added to jumplist you can return using ctrl + o
vim.keymap.set('n', 'k', function()
    if vim.v.count > 0 then
        return "m'" .. vim.v.count .. 'k'
    end
    return 'k'
end, { desc = '', expr = true })

vim.keymap.set('x', '/', '<Esc>/\\%V', { desc = 'Search within Visual Area' })

vim.keymap.set('n', '[[', 'zczkzo%0', { desc = 'Jump to previous fold' })
vim.keymap.set('n', ']]', 'zczjzo', { desc = 'Jump to next fold' })
--
-- vim: ts=2 sts=2 sw=2 et
