" Keep Neovim's Lua highlights when both colorscheme files are installed.
if has('nvim')
  execute 'luafile ' . fnameescape(expand('<sfile>:p:r') . '.lua')
  finish
endif

set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'kataware'

" GUI/true-color values and their nearest xterm-256 equivalents.
let s:p = {
      \ 'void': ['#0B1020', 233],
      \ 'night': ['#10172A', 234],
      \ 'surface': ['#151F38', 235],
      \ 'surface_high': ['#1D2A49', 236],
      \ 'border': ['#2B3B62', 238],
      \ 'muted': ['#6B7FA2', 67],
      \ 'dim': ['#A8B7D0', 146],
      \ 'fg': ['#D9E2F2', 189],
      \ 'starlight': ['#EEF3FF', 255],
      \ 'comet': ['#60D7E8', 80],
      \ 'blue': ['#6CA8FF', 75],
      \ 'violet': ['#9B8CFF', 105],
      \ 'pink': ['#F08BC3', 211],
      \ 'red': ['#F2778B', 210],
      \ 'gold': ['#F2C38B', 216],
      \ 'green': ['#82D2B2', 115],
      \ 'diff_add': ['#142C31', 235],
      \ 'diff_change': ['#182846', 236],
      \ 'diff_delete': ['#2D192A', 235],
      \ 'diff_text': ['#253A68', 238],
      \ 'NONE': ['NONE', 'NONE'],
      \ }
let s:editor_bg = get(g:, 'kataware_transparent', 0) ? 'NONE' : 'void'
let s:surface_bg = get(g:, 'kataware_transparent', 0) ? 'NONE' : 'surface'
let s:night_bg = get(g:, 'kataware_transparent', 0) ? 'NONE' : 'night'

function! s:Hi(group, fg, bg, ...) abort
  let l:attr = a:0 ? a:1 : 'NONE'
  execute 'highlight ' . a:group
        \ . ' guifg=' . s:p[a:fg][0] . ' guibg=' . s:p[a:bg][0]
        \ . ' ctermfg=' . s:p[a:fg][1] . ' ctermbg=' . s:p[a:bg][1]
        \ . ' gui=' . l:attr . ' cterm=' . l:attr . ' term=' . l:attr
        \ . ' guisp=' . (a:0 > 1 ? s:p[a:2][0] : 'NONE')
endfunction

" Editor surfaces.
call s:Hi('Normal', 'fg', s:editor_bg)
call s:Hi('NormalNC', 'dim', s:editor_bg)
call s:Hi('NormalFloat', 'fg', s:surface_bg)
call s:Hi('PopupNotification', 'fg', s:surface_bg)
call s:Hi('ColorColumn', 'NONE', 'night')
call s:Hi('Cursor', 'void', 'starlight')
call s:Hi('CursorIM', 'void', 'comet')
call s:Hi('CursorColumn', 'NONE', 'night')
call s:Hi('CursorLine', 'NONE', 'night')
call s:Hi('CursorLineNr', 'gold', 'night', 'bold')
call s:Hi('LineNr', 'border', 'NONE')
call s:Hi('LineNrAbove', 'border', 'NONE')
call s:Hi('LineNrBelow', 'border', 'NONE')
call s:Hi('SignColumn', 'muted', s:editor_bg)
call s:Hi('FoldColumn', 'muted', s:editor_bg)
call s:Hi('Folded', 'dim', 'night')
call s:Hi('VertSplit', 'border', 'NONE')
call s:Hi('Visual', 'NONE', 'surface_high')
call s:Hi('VisualNOS', 'NONE', 'surface_high')
call s:Hi('Search', 'void', 'gold')
call s:Hi('IncSearch', 'void', 'pink', 'bold')
call s:Hi('CurSearch', 'void', 'comet', 'bold')
call s:Hi('MatchParen', 'starlight', 'border', 'bold')
call s:Hi('NonText', 'border', 'NONE')
call s:Hi('Whitespace', 'border', 'NONE')
call s:Hi('EndOfBuffer', get(g:, 'kataware_transparent', 0) ? 'border' : 'void', 'NONE')
call s:Hi('SpecialKey', 'border', 'NONE')
call s:Hi('Directory', 'comet', 'NONE')
call s:Hi('Title', 'violet', 'NONE', 'bold')
call s:Hi('Conceal', 'muted', 'NONE')
call s:Hi('Question', 'comet', 'NONE')
call s:Hi('MoreMsg', 'green', 'NONE')
call s:Hi('ModeMsg', 'gold', 'NONE', 'bold')
call s:Hi('WarningMsg', 'gold', 'NONE')
call s:Hi('ErrorMsg', 'red', 'NONE', 'bold')

" Chrome: selected rows and statuslines stay opaque in transparent mode.
call s:Hi('StatusLine', 'fg', 'surface')
call s:Hi('StatusLineNC', 'muted', 'night')
call s:Hi('StatusLineTerm', 'fg', 'surface')
call s:Hi('StatusLineTermNC', 'muted', 'night')
call s:Hi('TabLine', 'muted', 'night')
call s:Hi('TabLineFill', 'NONE', s:editor_bg)
call s:Hi('TabLineSel', 'void', 'comet', 'bold')
call s:Hi('Pmenu', 'dim', s:surface_bg)
call s:Hi('PmenuSel', 'starlight', 'surface_high', 'bold')
call s:Hi('PmenuSbar', 'NONE', s:night_bg)
call s:Hi('PmenuThumb', 'NONE', 'border')
call s:Hi('PmenuMatch', 'comet', s:surface_bg, 'bold')
call s:Hi('PmenuMatchSel', 'comet', 'surface_high', 'bold')
call s:Hi('QuickFixLine', 'starlight', 'surface_high', 'bold')
call s:Hi('WildMenu', 'void', 'comet')

" Core syntax.
call s:Hi('Comment', 'muted', 'NONE', 'italic')
call s:Hi('Constant', 'gold', 'NONE')
call s:Hi('String', 'green', 'NONE')
call s:Hi('Character', 'green', 'NONE')
call s:Hi('Number', 'gold', 'NONE')
call s:Hi('Boolean', 'gold', 'NONE', 'bold')
call s:Hi('Float', 'gold', 'NONE')
call s:Hi('Identifier', 'fg', 'NONE')
call s:Hi('Function', 'blue', 'NONE')
call s:Hi('Statement', 'violet', 'NONE')
call s:Hi('Conditional', 'violet', 'NONE')
call s:Hi('Repeat', 'violet', 'NONE')
call s:Hi('Label', 'pink', 'NONE')
call s:Hi('Operator', 'comet', 'NONE')
call s:Hi('Keyword', 'violet', 'NONE')
call s:Hi('Exception', 'pink', 'NONE')
call s:Hi('PreProc', 'pink', 'NONE')
call s:Hi('Include', 'violet', 'NONE')
call s:Hi('Define', 'pink', 'NONE')
call s:Hi('Macro', 'pink', 'NONE')
call s:Hi('PreCondit', 'pink', 'NONE')
call s:Hi('Type', 'comet', 'NONE')
call s:Hi('StorageClass', 'violet', 'NONE')
call s:Hi('Structure', 'comet', 'NONE')
call s:Hi('Typedef', 'comet', 'NONE')
call s:Hi('Special', 'pink', 'NONE')
call s:Hi('SpecialChar', 'gold', 'NONE')
call s:Hi('Tag', 'blue', 'NONE')
call s:Hi('Delimiter', 'dim', 'NONE')
call s:Hi('SpecialComment', 'muted', 'NONE', 'italic')
call s:Hi('Debug', 'red', 'NONE')
call s:Hi('Underlined', 'blue', 'NONE', 'underline')
call s:Hi('Ignore', 'muted', 'NONE')
call s:Hi('Error', 'red', 'NONE')
call s:Hi('Todo', 'void', 'gold', 'bold')

" Diffs and spelling.
call s:Hi('DiffAdd', 'green', 'diff_add')
call s:Hi('DiffChange', 'blue', 'diff_change')
call s:Hi('DiffDelete', 'red', 'diff_delete')
call s:Hi('DiffText', 'starlight', 'diff_text', 'bold')
call s:Hi('Added', 'green', 'NONE')
call s:Hi('Changed', 'blue', 'NONE')
call s:Hi('Removed', 'red', 'NONE')
call s:Hi('SpellBad', 'NONE', 'NONE', 'undercurl', 'red')
call s:Hi('SpellCap', 'NONE', 'NONE', 'undercurl', 'gold')
call s:Hi('SpellRare', 'NONE', 'NONE', 'undercurl', 'violet')
call s:Hi('SpellLocal', 'NONE', 'NONE', 'undercurl', 'comet')

" Palette for Vim's built-in terminal buffers.
call s:Hi('Terminal', 'fg', s:editor_bg)
let g:terminal_ansi_colors = [
      \ s:p.void[0], s:p.red[0], s:p.green[0], s:p.gold[0],
      \ s:p.blue[0], s:p.violet[0], s:p.comet[0], s:p.dim[0],
      \ s:p.muted[0], '#FF91A4', '#A0E0C2', '#FFD49F',
      \ '#91BAFF', '#B9ACFF', '#86E9F2', s:p.starlight[0],
      \ ]

delfunction s:Hi
unlet s:p s:editor_bg s:surface_bg s:night_bg
