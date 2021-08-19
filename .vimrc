" *************************************************************************
" my scripts
" *************************************************************************
set hlsearch

set number
set relativenumber

set nowrap

set tabstop=4
set shiftwidth=4
set autoindent

set wildmode=longest,full
set wildmenu

set mouse=a

set splitbelow

set dictionary+=/usr/share/dict/words
set complete+=k

set listchars=eol:↵,tab:\|\|,trail:~,extends:>,precedes:<,space:·
set list

" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" toggle paste mode
inoremap <leader>p <esc>:set paste!<cr>i
nnoremap <leader>p :set paste!<cr>

" *************************************************************************
" vundle
" *************************************************************************
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'https://hub.fastgit.org/gmarik/vundle'
Bundle 'https://hub.fastgit.org/flazz/vim-colorschemes'
Bundle 'https://hub.fastgit.org/preservim/nerdtree'
Bundle 'https://hub.fastgit.org/itchyny/vim-cursorword.git'
Bundle 'https://hub.fastgit.org/ntpeters/vim-better-whitespace'
Bundle 'https://hub.fastgit.org/vim-airline/vim-airline'
Bundle 'https://hub.fastgit.org/mileszs/ack.vim'
Bundle 'https://hub.fastgit.org/Shougo/vimproc.vim'
Bundle 'https://hub.fastgit.org/Shougo/vimshell.vim'
Bundle 'https://hub.fastgit.org/supermomonga/vimshell-inline-history.vim'
Bundle 'https://hub.fastgit.org/othree/xml.vim'
Bundle 'https://hub.fastgit.org/preservim/vimux'
Bundle 'https://hub.fastgit.org/mbbill/undotree'
Bundle 'https://hub.fastgit.org/preservim/tagbar'
Bundle 'https://hub.fastgit.org/tell-k/vim-autopep8'
Bundle 'https://hub.fastgit.org/davidhalter/jedi-vim'
Bundle 'https://hub.fastgit.org/jiangmiao/auto-pairs'
Bundle 'https://hub.fastgit.org/tpope/vim-surround'
Bundle 'https://hub.fastgit.org/luochen1990/rainbow'
Bundle 'https://hub.fastgit.org/ctrlpvim/ctrlp.vim'
Bundle 'https://hub.fastgit.org/FelikZ/ctrlp-py-matcher'
Bundle 'https://hub.fastgit.org/tpope/vim-fugitive'
Bundle 'https://hub.fastgit.org/airblade/vim-rooter'
Bundle 'https://hub.fastgit.org/junegunn/vim-peekaboo'
filetype plugin indent on

" *************************************************************************
" plugin config
" *************************************************************************
" flazz/vim-colorschemes
colorscheme molokai

" preservim/nerdtree
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMouseMode=2
"autocmd VimEnter * NERDTreeFocus

" Shougo/vimshell.vim
let g:vimshell_enable_start_insert=0
let g:vimshell_popup_height=30
"autocmd VimEnter * VimShellPop
"autocmd VimEnter * wincmd p | wincmd h

" preservim/tagbar
let g:tagbar_position = 'vertical leftabove'
let g:tagbar_width = max([25, winwidth(0) / 5])
"autocmd VimEnter * if argc() == 0 || (argc() == 1 && !isdirectory(argv()[0])) | TagbarToggle | endif

" mileszs/ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" davidhalter/jedi-vim
let g:jedi#show_call_signatures = "2"

" rainbow/luochen1990
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'separately': {
\	'nerdtree': 0,
\	}
\}

" ctrlpvim/ctrlp
let g:ctrlp_extensions = ['tag']

" FelikZ/ctrlp-py-matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350
" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0
" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0
" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

" *************************************************************************
" hotkeys
" *************************************************************************
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :VimShellPop<CR>
nnoremap <silent> <F4> :AirlineToggle<CR>
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
