-- A small, deliberate Neovim setup focused on navigation, code intelligence,
-- and fast feedback. Plugins are kept in lua/plugins so each concern stays
-- easy to change without turning init.lua into a monolith.

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.colors").load(true)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "matugen" } },
  checker = { enabled = false },
  change_detection = { enabled = false, notify = false },
  ui = { border = "rounded" },
})
