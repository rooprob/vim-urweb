if exists("b:did_indent")
        finish
endif

" note: indentkeys starts with xml.vim and concatonated by sml.vim.
" note: indentexpr is supplied by this vimscript.

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
	if <SID>InsideXml(v:lnum)
		return XmlIndentGet(v:lnum,1)
	endif
	return GetSMLIndent()
endfunction

setlocal indentexpr=UrIndent()
