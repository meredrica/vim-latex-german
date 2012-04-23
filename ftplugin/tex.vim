" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("b:did_ftplugin") || exists("g:loaded_latex_german_hack") || &cp
  finish
endif
let g:loaded_latex_german_hack= 123 " your version number
let s:keepcpo           = &cpo
set cpo&vim

" Public Interface:
" Appfuntion: is a funtion you expect your users to call
" PickAMap: some sequence of characters that will run your Appfuntion
" Repeat these three lines as needed for multiple funtions which will
" be used to provide an interface for the user
"
if !hasmapto('<Plug>LaTeXGermanToggle')
  map <unique> <Leader>FT <Plug>LaTeXGermanToggle
endif

" Global Maps:
"
map <silent> <unique> <script> <Plug>LaTeXGermanToggle
 \ :set lz<CR>:call <SID>LaTeXGermanToggle<CR>:set nolz<CR>

fun! s:LaTeXGermanToggle()
	let b:latex_german_hack_fixed = exists('b:latex_german_hack_fixed')? b:latex_german_hack_fixed : 0
	if b:latex_german_hack_fixed
		call s:NoLaTeXGermanFix()
	else
		call s:LaTeXGermanFix()
	endif
	let b:latex_german_hack_fixed=!b:latex_german_hack_fixed
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
	" TODO check how to only set it when it is not there yet
	set spelllang+=de
endfun

" autocmds so we actually do something
augroup LaTeXGermanFix
	au!
	au BufNewFile * :call s:LaTeXGerman()
	au BufRead * :call s:LaTeXGerman()
augroup END

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
