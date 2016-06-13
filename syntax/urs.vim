" ML-like interface file, with the .urs extension
if exists("b:current_syntax")
        finish
endif

" from https://github.com/cypok/vim-sml.git
runtime! syntax/sml.vim
unlet b:current_syntax

runtime! syntax/ur.vim

let b:current_syntax = "urs"
