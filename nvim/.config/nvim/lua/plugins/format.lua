return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        css = { "prettier" },
        go = { "gofmt" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        nix = { "nixfmt" },
        python = { "ruff_format", "black", stop_after_first = true },
        rust = { "rustfmt" },
        svelte = { "prettier" },
        toml = { "taplo" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local executable = vim.fn.executable
      local linters = {}

      if executable("ruff") == 1 then
        linters.python = { "ruff" }
      end
      if executable("eslint_d") == 1 then
        linters.javascript = { "eslint_d" }
        linters.javascriptreact = { "eslint_d" }
        linters.typescript = { "eslint_d" }
        linters.typescriptreact = { "eslint_d" }
        linters.svelte = { "eslint_d" }
      end
      if executable("shellcheck") == 1 then
        linters.sh = { "shellcheck" }
        linters.bash = { "shellcheck" }
      end
      if executable("yamllint") == 1 then
        linters.yaml = { "yamllint" }
      end

      lint.linters_by_ft = linters

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("user-lint", { clear = true }),
        callback = function()
          if vim.bo.modifiable and not vim.bo.readonly then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
