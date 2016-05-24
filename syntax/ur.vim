if exists("b:current_syntax")
        finish
endif

" from https://github.com/cypok/vim-sml.git
runtime! syntax/sml.vim
unlet b:current_syntax

syntax include @xml syntax/xml.vim
unlet b:current_syntax

syntax region xmlRegion matchgroup=xmlString start='<xml>' end='<\/xml>' contains=@xml
syntax match xmlString '<xml/>'
syntax match ursTemplate '{[^}]*}' containedin=xmlTag,xmlTagName,xmlAttrib,xmlRegion

syntax keyword ursType      int string real time
syntax keyword ursStatement Name Type Unit
syntax keyword ursKeyword   return con
syntax keyword ursInclude   dml

highlight link ursType Type
highlight link ursStatement Statement
highlight link ursKeyword   Keyword
highlight link ursTemplate  Include
highlight link ursInclude   Include
let b:current_syntax = "ur"
