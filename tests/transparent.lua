local script = debug.getinfo(1, 'S').source:sub(2)
local root = vim.fs.dirname(vim.fs.dirname(script))
vim.opt.runtimepath:prepend(root)

local function background(name)
  return vim.api.nvim_get_hl(0, { name = name }).bg
end

vim.g.kataware_transparent = true
vim.cmd.colorscheme 'kataware'

local transparent_groups = {
  'Normal',
  'NormalFloat',
  'FloatBorder',
  'Pmenu',
  'BlinkCmpMenu',
  'BlinkCmpDoc',
  'TelescopeNormal',
  'TelescopeBorder',
  'TelescopePromptNormal',
  'TelescopePromptBorder',
  'WhichKeyBorder',
}

for _, name in ipairs(transparent_groups) do
  assert(background(name) == nil, name .. ' must be transparent')
end

assert(background 'TelescopeSelection' == 0x1D2A49, 'Telescope selection must remain readable')
assert(background 'StatusLine' == 0x151F38, 'statusline must remain readable')

vim.g.kataware_transparent = false
vim.cmd.colorscheme 'kataware'

assert(background 'Normal' == 0x0B1020, 'opaque editor background changed')
assert(background 'NormalFloat' == 0x151F38, 'opaque float background changed')
assert(background 'TelescopeNormal' == 0x151F38, 'opaque Telescope background changed')
assert(background 'TelescopePromptNormal' == 0x1D2A49, 'opaque Telescope prompt background changed')

print 'transparent and opaque modes: OK'
