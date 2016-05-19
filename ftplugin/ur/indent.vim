if exists("b:did_indent")
        finish
endif

" from https://github.com/cypok/vim-sml.git
runtime! indent/sml.vim
unlet b:did_indent

