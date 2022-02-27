" *************************************************************************
" presettings
" *************************************************************************
set encoding=utf8

" *************************************************************************
" vundle plugins
" *************************************************************************
let $GIT_SITE = 'https://hub.fastgit.xyz/'

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle $GIT_SITE.'VundleVim/Vundle.vim'
Bundle $GIT_SITE.'flazz/vim-colorschemes'
Bundle $GIT_SITE.'preservim/nerdtree'
Bundle $GIT_SITE.'itchyny/vim-cursorword.git'
Bundle $GIT_SITE.'ntpeters/vim-better-whitespace'
Bundle $GIT_SITE.'vim-airline/vim-airline'
Bundle $GIT_SITE.'mileszs/ack.vim'
Bundle $GIT_SITE.'Shougo/vimproc.vim'
Bundle $GIT_SITE.'Shougo/vimshell.vim'
Bundle $GIT_SITE.'supermomonga/vimshell-inline-history.vim'
Bundle $GIT_SITE.'othree/xml.vim'
Bundle $GIT_SITE.'mbbill/undotree'
Bundle $GIT_SITE.'preservim/tagbar'
Bundle $GIT_SITE.'tell-k/vim-autopep8'
Bundle $GIT_SITE.'jiangmiao/auto-pairs'
Bundle $GIT_SITE.'tpope/vim-surround'
Bundle $GIT_SITE.'luochen1990/rainbow'
Bundle $GIT_SITE.'ctrlpvim/ctrlp.vim'
Bundle $GIT_SITE.'FelikZ/ctrlp-py-matcher'
Bundle $GIT_SITE.'tpope/vim-fugitive'
Bundle $GIT_SITE.'airblade/vim-rooter'
Bundle $GIT_SITE.'junegunn/vim-peekaboo'
Bundle $GIT_SITE.'preservim/nerdcommenter'
Bundle $GIT_SITE.'severin-lemaignan/vim-minimap'
Bundle $GIT_SITE.'vim-scripts/YankRing.vim'
Bundle $GIT_SITE.'farmergreg/vim-lastplace'
call vundle#end()
filetype plugin indent on

" *************************************************************************
" plugin configs
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
\   'separately': {
\   'nerdtree': 0,
\   }
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

" vim-scripts/YankRing.vim
" to avoid <C-p> collision with the ctrlp plugin
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'
" save yankring history in this dir
if !isdirectory($HOME."/.vim/yankring-dir")
    call mkdir($HOME."/.vim/yankring-dir", "", 0700)
endif
let g:yankring_history_dir = $HOME.'/.vim/yankring-dir'

" *************************************************************************
" my scripts
" *************************************************************************
set novisualbell

set t_Co=256
syntax on

set hlsearch

set number
set relativenumber

set nowrap

set tabstop=4
set shiftwidth=4
set expandtab

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
" from https://vi.stackexchange.com/a/53
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" *************************************************************************
" my functions
" *************************************************************************
" allow toggling between local and default mode
" https://vim.fandom.com/wiki/Toggle_between_tabs_and_spaces
function! TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunction

"*************************************************************************
" file types
" *************************************************************************
" scons
augroup scons_ft
  au!
  autocmd BufNewFile,BufRead SConstruct set filetype=python
augroup END

" *************************************************************************
" hotkeys
" *************************************************************************
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :VimShellPop<CR>
nnoremap <silent> <F4> :UndotreeToggle<CR>
nnoremap <silent> <F5> :AirlineToggle<CR>
nnoremap <silent> <F7> :YRShow<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :MinimapToggle<CR>

" toggle paste mode
inoremap <leader>p <esc>:set paste!<cr>i
nnoremap <leader>p :set paste!<cr>

" toggle list char
inoremap <leader>l <esc>:set list!<cr>i
nnoremap <leader>l :set list!<cr>

" toggle tab/spaces
inoremap <leader>t <esc>:call TabToggle()<cr>i
nnoremap <leader>t :call TabToggle()<cr>
