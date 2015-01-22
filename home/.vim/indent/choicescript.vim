" Vim indent file (that doesn't seem to do anything)
" Language: choiceScript

if exists("b:did_indent")
  finish
endif
unlet! b:did_indent
let b:did_indent = 1

setlocal autoindent

setlocal indentexpr=getChoiceScriptIndent()
setlocal indentkeys=o,O,*<Return>

" Only define the function once.
if exists("*GetChoiceScriptIndent")
  finish
endif

function GetChoiceScriptIndent()
  let lnum = prevnoblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let line = substitute(substitute(getline(lnum), '\s\+$', '', ''), '^\s\+', '', '')
  let indent = indent(lnum)
  let increase = indent + shiftwidth()
  let decrease = indent - shiftwidth()

  " if line =~ '\*(fake_)?choice'
  if line =~? '\*choice'
    return increase
  elseif line =~ '#'
    return increase
  " elseif line =~ '\*goto\|\*finish'
  elseif line =~ '\*finish'
    return decrease
  elseif line =~ '\*goto'
    return decrease
  else
    return indent
  end
endfunction
