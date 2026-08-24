return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "super-tab" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
        ghost_text = { enabled = true },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
