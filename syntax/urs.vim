" ML-like signature file, with the .urs extension
if exists("b:current_syntax")
        finish
endif

" from https://github.com/cypok/vim-sml.git
runtime! syntax/sml.vim
unlet b:current_syntax

syntax keyword ursKeyword class transaction page
highlight link ursKeyword Keyword

let b:current_syntax = "urs"
