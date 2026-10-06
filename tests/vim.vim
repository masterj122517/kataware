let s:root = fnamemodify(expand('<sfile>:p'), ':h:h')
execute 'set runtimepath^=' . fnameescape(s:root)
set t_Co=256
syntax enable

function! s:Background(group, mode) abort
  return synIDattr(hlID(a:group), 'bg', a:mode)
endfunction

try
  let g:kataware_transparent = 0
  colorscheme kataware
  let s:canvas = ['Normal', 'SignColumn', 'FoldColumn', 'TabLineFill', 'Pmenu', 'PmenuSbar', 'Terminal']
  let s:readable = ['StatusLine', 'PmenuSel', 'Visual', 'Search', 'DiffAdd']
  let s:opaque = {}
  for s:mode in ['gui', 'cterm']
    for s:group in s:canvas + s:readable
      let s:key = s:mode . ':' . s:group
      let s:opaque[s:key] = s:Background(s:group, s:mode)
      call assert_notequal('', s:opaque[s:key], s:key . ' needs an opaque background')
    endfor
  endfor

  let g:kataware_transparent = 1
  colorscheme kataware
  for s:mode in ['gui', 'cterm']
    for s:group in s:canvas
      call assert_equal('', s:Background(s:group, s:mode), s:mode . ':' . s:group . ' must be transparent')
    endfor
    for s:group in s:readable
      let s:key = s:mode . ':' . s:group
      call assert_equal(s:opaque[s:key], s:Background(s:group, s:mode), s:key . ' must retain contrast')
    endfor
  endfor

  let g:kataware_transparent = 0
  colorscheme kataware
  for s:mode in ['gui', 'cterm']
    for s:group in s:canvas + s:readable
      let s:key = s:mode . ':' . s:group
      call assert_equal(s:opaque[s:key], s:Background(s:group, s:mode), s:key . ' must restore its background')
    endfor
  endfor
catch
  call add(v:errors, v:exception . ' at ' . v:throwpoint)
endtry

if !empty(v:errors)
  for s:error in v:errors
    echoerr s:error
  endfor
  cquit
endif
echo 'Vim transparent and opaque modes: OK'
qa!
