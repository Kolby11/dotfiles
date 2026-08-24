return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "nil_ls",
        "pyright",
        "rust_analyzer",
        "svelte",
        "ts_ls",
        "yamlls",
      },
      automatic_enable = true,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local on_attach = function(_, bufnr)
        local function buffer_map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        buffer_map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        buffer_map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        buffer_map("n", "gr", vim.lsp.buf.references, "Find references")
        buffer_map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
        buffer_map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        buffer_map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        buffer_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        buffer_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        buffer_map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
        buffer_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        buffer_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        buffer_map("n", "<leader>wl", vim.lsp.buf.list_workspace_folders, "List workspace folders")
      end

      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
            },
          },
        },
        ts_ls = {
          init_options = { preferences = { includeCompletionsForModuleExports = true } },
        },
        jsonls = {
          settings = { json = { validate = { enable = true } } },
        },
        yamlls = {
          settings = { yaml = { keyOrdering = false } },
        },
      }

      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
      end

      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
}
