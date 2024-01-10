--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.o`

local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 100,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  laststatus = 3,
  showcmd = false,
  ruler = false,
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  -- guifont = "JetBrainsMono Nerd Font Mono:h14",               -- the font used in graphical neovim applications
  -- guifont = "NotoSans Nerd Font Mono:h14",
  title = true,
  -- colorcolumn = "80",
  -- colorcolumn = "120",
  -- shell = "/usr/bin/zsh"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Custom functions
function execute_file_h_split()
  local file = vim.fn.expand('%') -- Get the current file path
  local cmd = ""

  if file:match('%.py$') then
    cmd = "python3 " .. file
  elseif file:match('%.js$') then
    cmd = "node " .. file
  else
    print("Unsupported file type")
    return
  end

  vim.cmd('split | terminal ' .. cmd)
end

function entr_v_split()
  local file = vim.fn.expand('%') -- Get the current file path
  local cmd = ""

   if file:match('%.py$') then
    cmd = "echo " .. file .. " | entr -c python3 " .. file
  elseif file:match('%.js$') then
    cmd = "echo " .. file .. " | entr -r node " .. file
  else
    print("Unsupported file type")
    return
  end

  vim.cmd('vsplit | terminal ' .. cmd)
end

-- Custom keymaps
keymap({'n', 'v', 'i'}, '<C-s>', '<Esc>:w<CR>:echo "File saved!"<CR>', opts)
keymap('n', '<leader>fs', ':w<CR>:echo "File saved!"<CR>', opts)
keymap('n', '<leader>fsq', ':wqa<CR>', opts)
keymap('n', '<leader>ffq', ':qa!<CR>', opts)
keymap('n', '<leader>fq', ':q<CR>', opts)
keymap('n', '<leader>fsn', [[:w <BAR> execute 'saveas ' .. input('Save file as: ')<CR>]], opts)
keymap('n', '<leader>fo', [[:split <BAR> execute "edit " .. input('Enter file name: ')<CR>]], opts)
keymap('n', '<leader>xf', ':lua execute_file_h_split()<CR>', opts)
keymap('n', '<leader>xw', ':lua entr_v_split()<CR><C-w><C-w><CR>', opts)

vim.cmd("colorscheme desert")

-- NEOVIDE SETTINGS
if vim.g.neovide then
  vim.g.neovide_transparency = .95
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_theme = 'auto'
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_profiler = false -- test this out
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_vfx_mode = "" -- railgun, torpedo, pixiedust, sonicboom, ripple, wireframe
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set({'n', 'v'}, '<D-v>', '"+P') -- Paste normal, visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
end

-- NEOVIDE NVIM RECOMMEDED SETTINGS?
-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
