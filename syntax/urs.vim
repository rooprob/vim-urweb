" ML-like signature file, with the .urs extension
if exists("b:current_syntax")
        finish
endif

syntax keyword ursKeyword val transaction page
syntax keyword ursFunction unit string

highlight link ursKeyword Keyword
highlight link ursFunction Function

let b:current_syntax = "urs"
