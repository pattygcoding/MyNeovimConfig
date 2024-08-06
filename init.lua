-- Ensure packer.nvim is loaded
vim.cmd [[packadd packer.nvim]]

-- Initialize packer.nvim
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Add syntax highlighting for C#
    use 'sheerun/vim-polyglot'

    -- Optionally, you can add a theme for better color support
    use 'gruvbox-community/gruvbox'

    -- Tagbar plugin
    use 'preservim/tagbar'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons',
        }
    }
end)

require'nvim-tree'.setup {}

-- Mouse support
vim.o.mouse = 'a'

-- Set the leader key to comma
vim.g.mapleader = ','

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable file type detection and plugins
vim.cmd('filetype plugin indent on')

-- Set a color scheme (optional)
vim.cmd('colorscheme gruvbox')

-- Ensure UTF-8 encoding
vim.o.encoding = 'UTF-8'

-- Copy to system clipboard using Ctrl+c in Visual mode
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- Paste from system clipboard using Ctrl+v in Insert mode
vim.api.nvim_set_keymap('i', '<C-v>', '<C-R>+', { noremap = true, silent = true })

-- Set the keymap for undo
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>:undo<CR>', { noremap = true, silent = true })

-- Set the keymap for redo
vim.api.nvim_set_keymap('i', '<C-y>', '<C-o>:redo<CR>', { noremap = true, silent = true })

-- Tagbar configuration
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- Keybinding for Nvim Tree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

function StayInInsertModeOnClick()
    if vim.fn.mode() == 'v' then
        vim.cmd('startinsert')
    end
end

-- Auto-command group to trigger the function on CursorMoved event
vim.cmd([[
    augroup StayInInsert
        autocmd!
        autocmd CursorMoved * lua StayInInsertModeOnClick()
    augroup END
]])

local function set_tab_options()
    local filetype = vim.bo.filetype
    if filetype == 'javascript' or filetype == 'vue' then
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true
    else
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.expandtab = false
    end
  end
  
  -- Auto command to trigger the function when a buffer is entered or the file type is detected
  vim.api.nvim_create_autocmd({'BufEnter', 'FileType'}, {
    pattern = {'*.js', '*.vue', '*'},
    callback = set_tab_options
  })
