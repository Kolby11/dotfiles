local M = {}

M.path = vim.fn.expand("~/.local/state/quickshell/user/generated/colors.json")
M._stamp = nil

local fallback = {
  background = "#131313",
  surface = "#131313",
  surface_container = "#1f201f",
  surface_container_high = "#2a2a2a",
  surface_container_highest = "#353534",
  on_surface = "#e4e2e1",
  on_surface_variant = "#c3c8c5",
  outline = "#8d9290",
  outline_variant = "#424846",
  primary = "#bcc9c6",
  on_primary = "#273330",
  primary_container = "#6b7875",
  secondary = "#c3c7c5",
  secondary_container = "#434846",
  tertiary = "#dac1ba",
  tertiary_container = "#86716b",
  error = "#ffb4ab",
  on_error = "#690005",
}

local function read_palette()
  local file = io.open(M.path, "r")
  if not file then
    return vim.deepcopy(fallback)
  end

  local content = file:read("*a")
  file:close()
  local ok, decoded = pcall(vim.json.decode, content)
  if not ok or type(decoded) ~= "table" then
    return vim.deepcopy(fallback)
  end
  return vim.tbl_deep_extend("force", vim.deepcopy(fallback), decoded)
end

local function set(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(group, target)
  set(group, { link = target })
end

function M.apply(c)
  vim.cmd("highlight clear")
  vim.o.background = "dark"
  vim.g.colors_name = "matugen"

  set("Normal", { fg = c.on_surface, bg = c.surface })
  set("NormalNC", { fg = c.on_surface_variant, bg = c.surface })
  set("NormalFloat", { fg = c.on_surface, bg = c.surface_container })
  set("FloatBorder", { fg = c.outline, bg = c.surface_container })
  set("FloatTitle", { fg = c.primary, bg = c.surface_container, bold = true })
  set("CursorLine", { bg = c.surface_container_low or c.surface_container })
  set("CursorLineNr", { fg = c.primary, bold = true })
  set("LineNr", { fg = c.outline })
  set("SignColumn", { fg = c.on_surface_variant, bg = c.surface })
  set("Visual", { bg = c.primary_container, fg = c.on_primary_container or c.on_surface })
  set("Search", { bg = c.tertiary_container, fg = c.on_surface })
  set("IncSearch", { bg = c.primary, fg = c.on_primary, bold = true })
  set("CurSearch", { link = "IncSearch" })
  set("MatchParen", { bg = c.surface_container_highest, fg = c.primary, bold = true })
  set("Pmenu", { bg = c.surface_container, fg = c.on_surface })
  set("PmenuSel", { bg = c.primary_container, fg = c.on_surface })
  set("PmenuSbar", { bg = c.surface_container_highest })
  set("PmenuThumb", { bg = c.outline })
  set("StatusLine", { bg = c.surface_container_high, fg = c.on_surface })
  set("StatusLineNC", { bg = c.surface_container, fg = c.on_surface_variant })
  set("TabLine", { bg = c.surface_container, fg = c.on_surface_variant })
  set("TabLineSel", { bg = c.primary_container, fg = c.on_surface, bold = true })
  set("TabLineFill", { bg = c.surface })
  set("WinSeparator", { fg = c.outline_variant, bg = c.surface })
  set("Directory", { fg = c.primary })
  set("Folded", { fg = c.on_surface_variant, bg = c.surface_container })
  set("NonText", { fg = c.outline_variant })
  set("Whitespace", { fg = c.outline_variant })
  set("SpecialKey", { fg = c.outline })
  set("Title", { fg = c.primary, bold = true })
  set("Question", { fg = c.tertiary })
  set("MoreMsg", { fg = c.primary })
  set("ErrorMsg", { fg = c.error, bold = true })
  set("WarningMsg", { fg = c.tertiary })

  set("Comment", { fg = c.outline, italic = true })
  set("String", { fg = c.tertiary })
  set("Character", { fg = c.tertiary })
  set("Number", { fg = c.tertiary })
  set("Boolean", { fg = c.tertiary })
  set("Constant", { fg = c.tertiary })
  set("Identifier", { fg = c.on_surface })
  set("Function", { fg = c.primary, bold = true })
  set("Statement", { fg = c.primary })
  set("Keyword", { fg = c.primary })
  set("Operator", { fg = c.primary })
  set("Type", { fg = c.secondary })
  set("Structure", { fg = c.secondary })
  set("Special", { fg = c.tertiary })
  set("PreProc", { fg = c.secondary })
  set("Tag", { fg = c.primary })
  set("Delimiter", { fg = c.on_surface_variant })

  set("DiagnosticError", { fg = c.error })
  set("DiagnosticWarn", { fg = c.tertiary })
  set("DiagnosticInfo", { fg = c.primary })
  set("DiagnosticHint", { fg = c.secondary })
  set("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
  set("DiagnosticUnderlineWarn", { undercurl = true, sp = c.tertiary })
  set("DiagnosticUnderlineInfo", { undercurl = true, sp = c.primary })
  set("DiagnosticUnderlineHint", { undercurl = true, sp = c.secondary })

  set("GitSignsAdd", { fg = c.secondary })
  set("GitSignsChange", { fg = c.primary })
  set("GitSignsDelete", { fg = c.error })
  set("DiffAdd", { fg = c.secondary, bg = c.surface_container_low })
  set("DiffChange", { fg = c.primary, bg = c.surface_container_low })
  set("DiffDelete", { fg = c.error, bg = c.surface_container_low })
  set("DiffText", { fg = c.on_surface, bg = c.primary_container })

  link("@comment", "Comment")
  link("@string", "String")
  link("@number", "Number")
  link("@constant", "Constant")
  link("@variable", "Identifier")
  link("@function", "Function")
  link("@keyword", "Keyword")
  link("@type", "Type")
  link("@tag", "Tag")
  link("@property", "Identifier")
  link("@punctuation.delimiter", "Delimiter")

  local terminal = {
    c.background,
    c.error,
    c.secondary,
    c.tertiary,
    c.primary,
    c.tertiary,
    c.secondary,
    c.on_surface,
    c.outline,
    c.error,
    c.primary,
    c.tertiary,
    c.primary,
    c.tertiary,
    c.secondary,
    c.on_surface,
  }
  for index, color in ipairs(terminal) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

function M.load(force)
  local stat = vim.uv.fs_stat(M.path)
  local stamp = stat and (tostring(stat.mtime.sec) .. ":" .. tostring(stat.mtime.nsec)) or "missing"
  if not force and stamp == M._stamp then
    return
  end
  M.apply(read_palette())
  M._stamp = stamp
end

vim.api.nvim_create_user_command("MatugenReload", function()
  M.load(true)
end, { desc = "Reload the Matugen Neovim palette" })

return M
