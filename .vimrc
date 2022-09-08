" *************************************************************************
" presettings
" *************************************************************************
set encoding=utf8

" *************************************************************************
" vundle plugins
" *************************************************************************

let $GITHUB_SITE = 'https://github.91chi.fun/https://github.com/'
"let $GITHUB_SITE = 'https://hub.fastgit.xyz/'
"let $GITHUB_SITE = 'https://github.com/'

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugin manager
Bundle $GITHUB_SITE.'VundleVim/Vundle.vim'

" color schemes
Bundle $GITHUB_SITE.'flazz/vim-colorschemes'

" mostly used
Bundle $GITHUB_SITE.'preservim/nerdtree'
Bundle $GITHUB_SITE.'vim-airline/vim-airline'
Bundle $GITHUB_SITE.'Shougo/vimproc.vim'
Bundle $GITHUB_SITE.'Shougo/vimshell.vim'
Bundle $GITHUB_SITE.'supermomonga/vimshell-inline-history.vim'
Bundle $GITHUB_SITE.'mbbill/undotree'
Bundle $GITHUB_SITE.'preservim/tagbar'

" more convenience
Bundle $GITHUB_SITE.'luochen1990/rainbow'
Bundle $GITHUB_SITE.'itchyny/vim-cursorword.git'
Bundle $GITHUB_SITE.'ntpeters/vim-better-whitespace'
Bundle $GITHUB_SITE.'jiangmiao/auto-pairs'
Bundle $GITHUB_SITE.'tpope/vim-surround'
Bundle $GITHUB_SITE.'airblade/vim-rooter'
Bundle $GITHUB_SITE.'junegunn/vim-peekaboo'
Bundle $GITHUB_SITE.'preservim/nerdcommenter'
Bundle $GITHUB_SITE.'vim-scripts/YankRing.vim'
Bundle $GITHUB_SITE.'farmergreg/vim-lastplace'

" git related
Bundle $GITHUB_SITE.'tpope/vim-fugitive'
Bundle $GITHUB_SITE.'junegunn/gv.vim'

" finders
Bundle $GITHUB_SITE.'ctrlpvim/ctrlp.vim'
Bundle $GITHUB_SITE.'FelikZ/ctrlp-py-matcher'
Bundle $GITHUB_SITE.'mileszs/ack.vim'

" code formatters
Bundle $GITHUB_SITE.'google/vim-maktaba'
Bundle $GITHUB_SITE.'google/vim-codefmt'
Bundle $GITHUB_SITE.'google/vim-glaive'

" language related
Bundle $GITHUB_SITE.'othree/xml.vim'

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

" Shougo/vimshell.vim
let g:vimshell_enable_start_insert=1
let g:vimshell_popup_height=30

" preservim/tagbar
let g:tagbar_position = 'vertical leftabove'
let g:tagbar_width = max([25, winwidth(0) / 5])

" mileszs/ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!

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

" google/vim-maktaba
" work-around for windows
call maktaba#syscall#SetUsableShellRegex('\v^/bin/sh|cmd|cmd\.exe|command\.com$')

" google/vim-codefmt
call glaive#Install()

" *************************************************************************
" my scripts
" *************************************************************************
" to enable backspace key
" https://vi.stackexchange.com/a/2163
set backspace=indent,eol,start

set novisualbell

" to deal with REPLACE MODE problem on windows cmd or windows terminal
" https://superuser.com/a/1525060
set t_u7=

set t_Co=256
syntax on

set hlsearch
set incsearch

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

" to be compatable with older version
" https://stackoverflow.com/a/36374234/15283141
if has("patch-7.4.710")
    set listchars=eol:↵,tab:\|\|,trail:~,extends:>,precedes:<,space:·
else
    set listchars=eol:↵,tab:\|\|,trail:~,extends:>,precedes:<
endif
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
nnoremap <silent> <F9> :CtrlP<CR>

inoremap <silent> <F2> <Esc>:NERDTreeToggle<CR>
inoremap <silent> <F3> <Esc>:VimShellPop<CR>
inoremap <silent> <F4> <Esc>:UndotreeToggle<CR>
inoremap <silent> <F5> <Esc>:AirlineToggle<CR>
inoremap <silent> <F7> <Esc>:YRShow<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR>
inoremap <silent> <F9> <Esc>:CtrlP<CR>

" quickly edit this config file
nnoremap <leader>ve :e $MYVIMRC<CR>
" quickly save and source this config file
nnoremap <leader>vs :wa<Bar>so $MYVIMRC<CR>
inoremap <leader>vs <Esc>:wa<Bar>so $MYVIMRC<CR>a

" toggle paste mode
inoremap <leader>p <Esc>:set paste!<CR>a
nnoremap <leader>p :set paste!<CR>

" toggle list char
inoremap <leader>l <Esc>:set list!<CR>a
nnoremap <leader>l :set list!<CR>

" toggle tab/spaces
inoremap <leader>t <Esc>:call TabToggle()<CR>a
nnoremap <leader>t :call TabToggle()<CR>

" google auto format
inoremap <leader>f <Esc>:FormatLines<CR>a
nnoremap <leader>f :FormatLines<CR>
inoremap <leader>F <Esc>:FormatCode<CR>a
nnoremap <leader>F :FormatCode<CR>

" strip trailing whitespaces
inoremap <leader>s <Esc>:StripWhitespace<CR>a
nnoremap <leader>s :StripWhitespace<CR>

" search the word under the cursor
inoremap <leader>a :Ack!<CR>
nnoremap <leader>a :Ack!<CR>
" search the given word
inoremap <leader>A :Ack!<Space>
nnoremap <leader>A :Ack!<Space>
