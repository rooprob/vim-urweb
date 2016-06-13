if exists("b:did_indent")
        finish
endif

" note: indentkeys starts with xml.vim and concatonated by sml.vim.
" note: indentexpr is supplied by this vimscript.

" from vim74/indent/xml.vim
runtime! indent/xml.vim
unlet b:did_indent

" from https://github.com/cypok/vim-sml.git
runtime! indent/sml.vim
unlet b:did_indent

let b:did_indent = 1
if exists("*UrIndent")
	finish
endif

" [-- detect if we're within an XML block --]
function! <SID>InsideXml(lnum)
	let lnum = a:lnum
	let closing = 0
	let opening = 0

	echom lnum opening closing
	while lnum > 1
		let lnum = prevnonblank(lnum)
		let lastline = getline(lnum)
		if closing == 0 && lastline =~ '</xml>'
			let closing = lnum
			break
		elseif opening == 0 && lastline =~ '<xml>'
			let opening = lnum
			break
		endif
		let lnum = lnum - 1
	endwhile
	" current cursor is below an XML closing block
	if closing > 0 && closing >= opening
		return closing >= a:lnum
	endif
	" cursor is within a new XML block
	if closing < opening
		return a:lnum > opening
	endif
	return 0
endfunction

function! UrIndent()
        let line = getline(v:lnum)
	if <SID>InsideXml(v:lnum)
                echo "insideXml"
		return XmlIndentGet(v:lnum,1)
	endif
        echo "insideSML"

        " Indent supplemental to GetSMLIndent()
        let lnum = prevnonblank(v:lnum - 1)
        let ind = GetSMLIndent()
        let lline = getline(lnum)

echo "lline is " lline

        " XXX behave like case
        if lline =~ '^\s*\(datatype\)\>'
                let ind = ind - &sw + 2
        endif
        " overrule vim-sml for datatype
        if line =~ '^\s*|'
            let lastSwitch = search('\<\(datatype\)\>','bW')
            let switchLine = getline(lastSwitch)
            let switchLineIndent = indent(lastSwitch)
            if lline =~ '^\s*|'
                "return ind
            elseif switchLine =~ '\<datatype\>'
              return col(".") - 1
            endif
        endif
        " WIP The following statements are in development.
        " XXX correctly indent for side effects
        " XXX support ;
        if lline =~ '<-' && lline !~ ';$'
                let ind = ind + &sw
        endif
        if lline =~ ';'
        "        let ind = ind " - &sw
        endif
        " XXX basic record behaviours
        if lline =~ '{$'
                let ind = ind + &sw
        endif
        if lline =~ '}$'
                echo "lline is " lline " and ind "  ind
        "        let ind = ind " &sw
        endif
        " Indent if last line starts
        if lline =~ '^\s*\(and\|dml\|datatype\)\>'
                let ind = ind + &sw
        endif
        return ind
endfunction

setlocal indentexpr=UrIndent()
setlocal indentkeys+=0=and,0=;
