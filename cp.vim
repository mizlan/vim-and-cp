" for detecting OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" important option that should already be set!
set hidden

" available options:
" * g:split_term_style
" * g:split_term_resize_cmd
function! TermWrapper(command) abort
	if !exists('g:split_term_style') | let g:split_term_style = 'vertical' | endif
	if g:split_term_style ==# 'vertical'
		let buffercmd = 'vnew'
	elseif g:split_term_style ==# 'horizontal'
		let buffercmd = 'new'
	else
		echoerr 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'' but is currently set to ''' . g:split_term_style . ''')'
		throw 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'')'
	endif
	if exists('g:split_term_resize_cmd')
		exec g:split_term_resize_cmd
	endif
	exec buffercmd
	exec 'term ' . a:command
	exec 'setlocal nornu nonu'
	exec 'startinsert'
endfunction

command! -nargs=0 CompileAndRun call TermWrapper(printf('g++ -std=c++11 %s && ./a.out', expand('%')))
command! -nargs=1 CompileAndRunWithFile call TermWrapper(printf('g++ -std=c++11 %s && ./a.out < %s', expand('%'), <args>))
autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>

" For those of you that like to use the default ./a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
" NOTE: this version is more stable than the other version with specified
" output executable!
augroup CppToolkit
	autocmd!
	if g:os == 'Darwin'
		autocmd FileType cpp nnoremap <leader>fn :!g++ -std=c++11 -o %:r % && open -a Terminal './a.out'<CR>
	endif
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 % && ./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>
augroup END

" For those of you that like to use -o and a specific outfile executable
" (i.e., xyz.cpp makes executable xyz, as opposed to a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
augroup CppToolkit
	autocmd!
	if g:os == 'Darwin'
		autocmd FileType cpp nnoremap <leader>fn :!g++ -std=c++11 -o %:r % && open -a Terminal './%:r'<CR>
	endif
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 -o %:r % && ./%:r<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./%:r.out<CR>
augroup END

" options
" choose between 'vertical' and 'horizontal' for how the terminal window is split
" (default is vertical)
let g:split_term_style = 'horizontal'

" add a custom command to resize the terminal window to your preference
" (default is to split the screen equally)
let g:split_term_resize_cmd = 'resize 6'
" (or let g:split_term_resize_cmd = 'vertical resize 40')
