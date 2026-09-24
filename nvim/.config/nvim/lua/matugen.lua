 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1c1e21',
    base01 = '#2f3237',
    base02 = '#2a2d32',
    base03 = '#66686f',
    base04 = '#b0b2b5',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#97949e',
    base0A = '#94949e',
    base0B = '#a2a4aa',
    base0C = '#bebcc2',
    base0D = '#bcbec2',
    base0E = '#bcbcc2',
    base0F = '#d7d7db',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#1c1e21' })
  hi('TelescopeBorder',         { fg = '#66686f',             bg = '#1c1e21' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#1c1e21' })
  hi('TelescopePromptBorder',   { fg = '#66686f',             bg = '#1c1e21' })
  hi('TelescopePromptPrefix',   { fg = '#a2a4aa',             bg = '#1c1e21' })
  hi('TelescopePromptCounter',  { fg = '#b0b2b5',  bg = '#1c1e21' })
  hi('TelescopePromptTitle',    { fg = '#1c1e21',             bg = '#a2a4aa' })
  hi('TelescopePreviewTitle',   { fg = '#1c1e21',             bg = '#94949e' })
  hi('TelescopeResultsTitle',   { fg = '#1c1e21',             bg = '#97949e' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#2a2d32' })
  hi('TelescopeSelectionCaret', { fg = '#a2a4aa',             bg = '#2a2d32' })
  hi('TelescopeMatching',       { fg = '#a2a4aa',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#1c1e21' })
  hi('MiniPickBorder',         { fg = '#66686f',             bg = '#1c1e21' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#1c1e21' })
  hi('MiniPickPromptPrefix',   { fg = '#a2a4aa',             bg = '#1c1e21' })
  hi('MiniPickBorderText',    { fg = '#1c1e21',             bg = '#a2a4aa' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#2a2d32' })
  hi('MiniPickPromptCaret', { fg = '#a2a4aa',             bg = '#2a2d32' })
  hi('MiniPickMatchRanges',       { fg = '#a2a4aa',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
