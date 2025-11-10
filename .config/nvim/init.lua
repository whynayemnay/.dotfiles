vim.g.mapleader = " "
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.g.netrw_keepdir = 0
require("config.lazy")
require("config.options")
