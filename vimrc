syntax enable
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set textwidth=110
set colorcolumn=120
highlight ColorColumn ctermbg=red
set number
set showcmd
set hlsearch
set cul

" Clang format for C, c++ files
function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-6.0/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp,*.c call Formatonsave()

" Install Vim Plugin by running the cli below
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()
Plug 'preservim/NERDTree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" Auto complete stuff
au filetype go inoremap <buffer> . .<C-x><C-o>
set completeopt=longest,menuone
