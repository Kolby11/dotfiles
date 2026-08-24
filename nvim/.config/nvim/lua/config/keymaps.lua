local map = vim.keymap.set

local function snacks_picker(name, opts)
  return function()
    Snacks.picker[name](opts)
  end
end

map({ "n", "v" }, "<C-s>", "<cmd>update<cr>", { desc = "Save buffer" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>qq", "<cmd>confirm qall<cr>", { desc = "Quit all" })
map("n", "<leader>w", "<cmd>update<cr>", { desc = "Write buffer" })
map("n", "<leader>bd", "<cmd>confirm bdelete<cr>", { desc = "Delete buffer" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

map("n", "<leader><space>", snacks_picker("smart"), { desc = "Find files" })
map("n", "<leader>ff", snacks_picker("files"), { desc = "Find files" })
map("n", "<leader>fg", snacks_picker("git_files"), { desc = "Find Git files" })
map("n", "<leader>fr", snacks_picker("recent"), { desc = "Recent files" })
map("n", "<leader>fb", snacks_picker("buffers"), { desc = "Buffers" })
map("n", "<leader>/", snacks_picker("grep"), { desc = "Search project" })
map("n", "<leader>sw", snacks_picker("grep_word"), { desc = "Search word" })
map("n", "<leader>sd", snacks_picker("diagnostics"), { desc = "Search diagnostics" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "File explorer" })
map("n", "<leader>st", function() Snacks.terminal() end, { desc = "Toggle terminal" })
map("n", "<C-\\>", function() Snacks.terminal() end, { desc = "Toggle terminal" })
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen mode" })
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Scratch buffer" })

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics list" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>ss", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Document symbols" })
map("n", "<leader>sr", "<cmd>GrugFar<cr>", { desc = "Search and replace" })

map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Open Lazygit" })
map("n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "Next Git hunk" })
map("n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "Previous Git hunk" })
map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Git hunk" })
map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Git hunk" })
map("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Git hunk" })
map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame line" })

map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load project session" })
map("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select session" })
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Load last session" })
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Stop session saving" })

map("n", "<leader>lf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
map("n", "<leader>uf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
end, { desc = "Toggle format on save" })
