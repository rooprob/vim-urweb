if exists("b:current_syntax")
        finish
endif

syntax keyword ursKeyword library database sql rewrite allow
syntax keyword ursFunction url responseHeader mime

highlight link ursKeyword Keyword
highlight link ursFunction Function
let b:current_syntax = "urp"
