if exists("b:current_syntax")
        finish
endif

" from https://github.com/cypok/vim-sml.git
runtime! syntax/sml.vim
unlet b:current_syntax
" from vim install
syntax include @xml syntax/xml.vim
unlet b:current_syntax

" XML highlighting
syntax region xmlRegion matchgroup=xmlString start='<xml>' end='<\/xml>' contains=@xml
syntax match xmlString '<xml/>'
" Handle ml inside XML tags
syntax region smlInsideXml matchgroup=smlEncl matchGroup=smlKeyword  start="{" matchgroup=smlKeyword end="}"  contains=ALLBUT,@smlContained,smlBraceErr containedin=xmlTag,xmlTagName,xmlAttrib,xmlRegion

" Additional keywords not included in sml
syntax keyword ursType      int string real time
syntax keyword ursStatement Name Type Unit
syntax keyword ursKeyword   return con style
syntax keyword ursInclude   dml

highlight link ursType Type
highlight link ursStatement Statement
highlight link ursKeyword   Keyword
highlight link ursInclude   Include
"Personal pref: mute the color of the <xml>..</xml> tags slightly.
highlight link xmlString    Comment
"mute color of xml region text
"highlight link xmlRegion    Comment
let b:current_syntax = "ur"
