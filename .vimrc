set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"*************LIST OF PLUGINS***********************************
" let Vundle manage Vundle, required

Plugin 'LaTeX-Suite-aka-Vim-LaTeX'

Plugin 'VundleVim/Vundle.vim'

Plugin 'itchyny/lightline.vim'

Plugin 'flazz/vim-colorschemes'

Plugin 'tpope/vim-fugitive'

Plugin 'sheerun/vim-polyglot'

Plugin 'rudrab/vimf90' 

Plugin 'syntastic'

Plugin 'scrooloose/nerdtree'


call vundle#end()

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=80
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

"reading files
set autoread

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

"++++++++++++++++++++++++gui graphics+++++++++++++++++++++++++++++++
"
let g:syntastic_quiet_messages = { "regex": [
        \ '\mpossible unwanted space at "{"',
                \ ] }


"let g:jellybeans_use_lowcolor_black = 0

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'

if !has('gui_running')
  set t_Co=256
endif

"syntastic settings:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

syntax on 
colorscheme onedark

filetype plugin on
if has('gui_running')
  set grepprg=grep\ -nH\ $*
  set guioptions-=T 
  set guifont=Monospace\ 9
  filetype indent on
  let g:tex_flavor='latex'
endif

"Filetype specific options
autocmd BufRead,BufNewFile *.tex colorscheme moria
autocmd BufRead,BufNewFile *.tex SyntasticT
