set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'
Plugin 'rking/ag.vim'
Plugin 'cespare/vim-toml'
Plugin 'vim-scripts/cg.vim'
Plugin 'vim-scripts/ShaderHighLight'

Plugin 'Valloric/YouCompleteMe'

" Color themes
Plugin 'jwhitley/vim-colors-solarized'


call vundle#end()            " required
filetype plugin indent on    " required

" Color scheme
syntax enable
set background=dark
colors solarized

" You Complete Me
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '??'
let g:ycm_autoclose_preview_window_after_insertion = 1

" Basic editing
set hidden
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set number
set relativenumber
set nowrap
set backspace=indent,eol,start
set scrolloff=3

if has("gui_running")
  set encoding=utf8
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guifont=Hack:h11:cRUSSIAN
endif

" Stuff for Russian
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
set spelllang=ru_ru,en_us

" No. Fucking. Beeping.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"""""" <Key bindings> """"""

map <space> <leader>
set pastetoggle=<F2>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>h :noh<CR>
nnoremap <silent> <leader>l :set cursorline! cursorline?<CR>
nnoremap <silent> <leader>e :Explore<CR>
nnoremap <silent> <leader>s :set invspell<CR>

nnoremap <silent> <leader>d :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>D :YcmDiags<CR>
nnoremap <silent> <leader>c :YcmForceCompileAndDiagnostics<CR>

nnoremap <silent> <leader>w :wa<CR>
nnoremap <silent> <leader>q :qa<CR>
nnoremap <silent> <leader>Q :qa!<CR>
nnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <leader>p "0p
vnoremap <leader>P "0P

nnoremap <silent> <leader>m :wa<CR>:make!<CR>
nnoremap <silent> <leader>r :!./build/game<CR>
nnoremap <silent> <leader>t :!sudo ./misc/profile.sh<CR>

nnoremap <silent> <leader>n :cn<CR>
nnoremap <silent> <leader>p :cN<CR>

nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>v :e $MYVIMRC<CR>

" Reselect after indent so it can easily be repeated
vnoremap < <gv
vnoremap > >gv

"""""" </Key bindings> """"""

" Auto-reload .vimrc on save
autocmd bufwritepost .vimrc source $MYVIMRC

" Large files
" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

" Delete comment character when joining commented lines
if v:version > 703
  set formatoptions+=j
endif


" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Auto-backup files and .swp files don't go to pwd
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Ctrl-P
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1

" ag
if (executable('ag'))
  " let g:ctrlp_user_command = 'ag -l --nocolor 
  "   \ --csharp --cc --cpp --batch --shell --js --json 
  "   \ --make --objc --objcpp --python --sql --xml --yaml 
  "   \ --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store 
  "   \ -g "" %s'
  let g:ctrlp_user_command = 'ag -l --nocolor 
    \ --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore *.meta
    \ -g "" %s'
endif
