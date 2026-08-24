local opt = vim.opt

opt.termguicolors = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.cursorlineopt = "number"
opt.laststatus = 3
opt.showmode = false
opt.ruler = false
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.completeopt = { "menu", "menuone", "noselect" }
opt.splitkeep = "screen"
opt.winblend = 8
opt.pumblend = 8
opt.confirm = true
opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
}

vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = "●" },
  signs = true,
  float = { border = "rounded", source = "if_many" },
})
