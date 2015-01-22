" Vim syntax file
" Language:     ChoiceScript
" Maintainer:   Ben Hamill

if exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn match choicescriptComments '\*comment .*$'

syn match choicescriptOption '#'

syn match choicescriptChoice '\*choice'
syn match choicescriptChoice '\*fake_choice'

syn match choicescriptCommands '\*disable_reuse'
syn match choicescriptCommands '\*set'
syn match choicescriptCommands '\*create'
syn match choicescriptCommands '\*author'
syn match choicescriptCommands '\*title'
syn match choicescriptCommands '\*page_break'

syn match choicescriptLabels '\*goto_scene'
syn match choicescriptLabels '\*goto'
syn match choicescriptLabels '\*label'

syn match choicescriptError '\*bug'

syn region choicescriptInterpolation start="\${" skip="\\}" end="}"

hi def link choicescriptComments        Comment
hi def link choicescriptCommands        Identifier
hi def link choicescriptLabels          Constant
hi def link choicescriptOption          String
hi def link choicescriptChoice          Conditional
hi def link choicescriptError           Exception
hi def link choicescriptInterpolation   Statement

let b:current_syntax = "choicescript"
