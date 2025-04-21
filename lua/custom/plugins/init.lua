-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    -- https://github.com/akinsho/toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        opts = {},
    },

    {
        'kdheepak/lazygit.nvim',
        lazy = true,
        cmd = {
            'LazyGit',
            'LazyGitConfig',
            'LazyGitCurrentFile',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        -- optional for floating window border decoration
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
        },
    },

    {
        'sindrets/diffview.nvim',
    },

    {
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            require('everforest').setup {
                -- Your config here
                background = 'hard',
                dim_inactive_windows = true,
            }
            vim.cmd.colorscheme 'everforest'
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {}
        end,
    },
}

-- vim: ts=4 sts=4 sw=4 et
