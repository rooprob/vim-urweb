if exists("b:current_syntax")
        finish
endif

syntax keyword ursKeyword library database
" Directives
syntax keyword ursDirectives allow deny alwaysInline benignEffectful clientOnly clientToServer coreInline exe file ffi html5 include jsFile jsFunc limit link linker minHeap monoInline noMangleSql noXsrfProtection onError path prefix  profile rewrite safeGet script sigfile sql timeFormat timeout url mime requestHeader responseHeader env meta

highlight link ursKeyword Keyword
highlight link ursDirectives Function
let b:current_syntax = "urp"
