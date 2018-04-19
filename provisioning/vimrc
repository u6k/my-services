" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,utf-8
set number
set hlsearch
set listchars=tab:~\ ,trail:~
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set showmatch
set title
set smartindent
set laststatus=2
set cursorline

syntax on

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'scrooloose/nerdtree'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck



map <C-n> :NERDTreeToggle<CR>
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>



augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

