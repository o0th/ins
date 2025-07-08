require("config.lazy")

vim.cmd.colorscheme("dracula")

vim.opt.clipboard:append("unnamedplus")
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 15
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.wo.number = true

vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("v", "y", '"+y', { noremap = true })
vim.keymap.set("x", "p", [["_dP]], { noremap = true, silent = true })
