local group = vim.api.nvim_create_augroup("productivity", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 180 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "gitcommit", "markdown", "text", "tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "bash",
    "c",
    "cpp",
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "markdown",
    "nix",
    "python",
    "rust",
    "sh",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "typescriptreact",
    "vim",
    "yaml",
  },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
    pcall(function()
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end)
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  callback = function()
    require("config.colors").load()
  end,
})
