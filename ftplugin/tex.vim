" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("b:did_ftplugin") || exists("g:loaded_latex_german") || &cp
  finish
endif
let g:loaded_latex_german= 123 " your version number
let s:keepcpo           = &cpo
set cpo&vim

if !hasmapto('<Plug>LaTeXGermanToggle')
  nmap <silent> <unique> FT :call <SID>LaTeXGermanToggle()<CR>

endif

let b:latex_german_fixed = 1

fun! s:LaTeXGermanToggle()
	if b:latex_german_fixed
		call s:NoLaTeXGermanFix()
	else
		call s:LaTeXGermanFix()
	endif
	let b:latex_german_fixed=!b:latex_german_fixed
endfun

fun! s:LaTeXGermanFix()
	silent! %s/ä/\\"a/gI
	silent! %s/Ä/\\"A/gI
	silent! %s/ö/\\"o/gI
	silent! %s/Ö/\\"O/gI
	silent! %s/ü/\\"u/gI
	silent! %s/Ü/\\"U/gI
	silent! %s/ß/\\ss{}/gI
	set nospell
endfun

fun! s:NoLaTeXGermanFix()
	silent! %s/\\"a/ä/gI
	silent! %s/\\"A/Ä/gI
	silent! %s/\\"o/ö/gI
	silent! %s/\\"O/Ö/gI
	silent! %s/\\"u/ü/gI
	silent! %s/\\"U/Ü/gI
	silent! %s/\\ss{}/ß/gI
	set spell
endfun

fun! s:LaTeXGerman()
	set iskeyword+=:
	set filetype=tex
	set spelllang+=de
endfun

" autocmd so we are loaded
au BufEnter *.tex,<tex> call <SID>LaTeXGerman()

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
