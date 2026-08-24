return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "▎" },
        untracked = { text = "┆" },
      },
      current_line_blame = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function buffer_map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = "Git: " .. desc })
        end
        buffer_map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
        buffer_map("n", "]g", function() gs.nav_hunk("next") end, "Next hunk")
        buffer_map("n", "[g", function() gs.nav_hunk("prev") end, "Previous hunk")
      end,
    },
  },
}
