return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

      -- Install the languages used by this machine in the background. The
      -- operation is a no-op for parsers that are already present.
      vim.defer_fn(function()
        pcall(treesitter.install, {
          "bash",
          "c",
          "cpp",
          "css",
          "diff",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "nix",
          "python",
          "query",
          "rust",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        })
      end, 1000)
    end,
  },
}
