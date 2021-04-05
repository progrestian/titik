" ENVVARS

set autoindent
set backspace=indent,eol,start
set complete-=i
set encoding=utf-8
set expandtab
set hidden
set incsearch
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
set mouse=a
set number
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2
set title
set whichwrap+=<,>,h,l,[,]

" CARET STYLE

let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
autocmd VimLeave * silent !echo -ne "\033]112\007"

" CTRL-* SHORTCUTS

noremap  <C-S> :w<CR>
nnoremap <C-Z> :u<CR>
inoremap <C-Z> <C-O>:u<CR>
vnoremap <C-X> "+x
vnoremap <C-C> "+y
noremap  <C-V> "+gP

" SET LEADING WHITESPACE

autocmd Filetype c setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd Filetype htm setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd Filetype xhtml setlocal ts=2 sts=2 sw=2 noexpandtab

" REGISTER-SAFE ACTIONS

noremap  x "_x
vnoremap p "_dP

" PREVENT CLEARING SELECTION AFTER INDENTATION

vnoremap > ><CR>gvll
vnoremap < <<CR>gvhh

" STRIP WHITESPACE

function StripWhitespace()
  normal mz
  normal Hmy
  %s/\s\+$//e
  normal 'yz<CR>
  normal `z
endfunction
