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

function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-6.0/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp,*.c call Formatonsave()
