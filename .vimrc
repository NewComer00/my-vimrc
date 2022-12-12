" *************************************************************************
" presettings
" *************************************************************************
set encoding=utf8
set nocompatible

if has('win32')
    let DATA_DIR = '$HOME/vimfiles'
else
    let DATA_DIR = '$HOME/.vim'
endif

" *************************************************************************
" vim plugins
" *************************************************************************

let GITHUB_SITE = 'https://github.91chi.fun/https://github.com/'
"let GITHUB_SITE = 'https://ghproxy.com/https://github.com/'
"let GITHUB_SITE = 'https://hub.fastgit.xyz/'
"let GITHUB_SITE = 'https://github.com/'
let GITHUB_RAW = 'https://raw.fastgit.org/'
"let GITHUB_RAW = 'https://ghproxy.com/https://raw.githubusercontent.com/'
"let GITHUB_RAW = 'https://raw.githubusercontent.com/'

" download the plugin manager if not installed
let AUTOLOAD_DIR =  DATA_DIR.'/autoload'
let PLUGIN_MANAGER_PATH = AUTOLOAD_DIR.'/plug.vim'
let PLUGIN_MANAGER_URL = GITHUB_RAW.'/junegunn/vim-plug/master/plug.vim'
if empty(glob(PLUGIN_MANAGER_PATH))
    echo 'Downloading plugin manager ...'
    if has('win32') && executable('powershell')
        silent execute '!powershell "iwr -useb '.PLUGIN_MANAGER_URL.' |`'
                    \ 'ni '.PLUGIN_MANAGER_PATH.' -Force"'
    elseif executable('wget')
        silent execute '!mkdir -p '.AUTOLOAD_DIR.' '
                    \ .'&& wget -O '.PLUGIN_MANAGER_PATH.' '.PLUGIN_MANAGER_URL.' '
                    \ .'&& echo "Download successful." || echo "Download failed." '
    elseif executable('curl')
        silent execute '!curl -fLo '.PLUGIN_MANAGER_PATH
                    \ .' --create-dirs '.PLUGIN_MANAGER_URL.' '
                    \ .'&& echo "Download successful." || echo "Download failed." '
    else
        echo 'Please download the plugin manager from '.PLUGIN_MANAGER_URL
                    \ .' and place it in '.PLUGIN_MANAGER_PATH
    endif
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" --------------------
" color schemes
" --------------------
Plug GITHUB_SITE.'flazz/vim-colorschemes'

" --------------------
" mostly used
" --------------------
Plug GITHUB_SITE.'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug GITHUB_SITE.'vim-airline/vim-airline'
if has('terminal')
    Plug GITHUB_SITE.'voldikss/vim-floaterm'
else
    Plug GITHUB_SITE.'Shougo/vimproc.vim', { 'do': 'make' }
    Plug GITHUB_SITE.'Shougo/vimshell.vim', { 'on': 'VimShellPop' }
    Plug GITHUB_SITE.'supermomonga/vimshell-inline-history.vim'
endif
Plug GITHUB_SITE.'mbbill/undotree'
Plug GITHUB_SITE.'preservim/tagbar', { 'on': 'TagbarToggle' }
" finders
Plug GITHUB_SITE.'ctrlpvim/ctrlp.vim'
Plug GITHUB_SITE.'mileszs/ack.vim'

" --------------------
" more convenience
" --------------------
Plug GITHUB_SITE.'luochen1990/rainbow'
Plug GITHUB_SITE.'itchyny/vim-cursorword.git'
Plug GITHUB_SITE.'ntpeters/vim-better-whitespace'
Plug GITHUB_SITE.'jiangmiao/auto-pairs'
Plug GITHUB_SITE.'tpope/vim-surround'
Plug GITHUB_SITE.'airblade/vim-rooter'
Plug GITHUB_SITE.'junegunn/vim-peekaboo'
Plug GITHUB_SITE.'preservim/nerdcommenter'
Plug GITHUB_SITE.'vim-scripts/YankRing.vim'
Plug GITHUB_SITE.'farmergreg/vim-lastplace'
" system clipboard
Plug GITHUB_SITE.'ojroques/vim-oscyank', { 'branch': 'main' }
Plug GITHUB_SITE.'christoomey/vim-system-copy'
" git related
Plug GITHUB_SITE.'tpope/vim-fugitive'
Plug GITHUB_SITE.'junegunn/gv.vim'
" vim performance
if has('timers') && has ('terminal')
    Plug GITHUB_SITE.'dstein64/vim-startuptime'
else
    Plug GITHUB_SITE.'NewComer00/startuptime.vim', { 'branch': 'patch-1' }
endif

" --------------------
" language related
" --------------------
Plug GITHUB_SITE.'othree/xml.vim'
" code formatters
Plug GITHUB_SITE.'google/vim-maktaba'
Plug GITHUB_SITE.'google/vim-codefmt', { 'on': ['FormatCode', 'FormatLines'] }
Plug GITHUB_SITE.'google/vim-glaive'

call plug#end()

" *************************************************************************
" plugin configs
" *************************************************************************

" flazz/vim-colorschemes
colorscheme molokai

" preservim/nerdtree
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMouseMode=2

if has('terminal')
    " voldikss/vim-floaterm
    let g:floaterm_wintype='split'
    let g:floaterm_height=0.3
    autocmd QuitPre * :FloatermKill!
else
    " Shougo/vimshell.vim
    let g:vimshell_enable_start_insert=1
    let g:vimshell_popup_height=30
endif

" preservim/tagbar
let g:tagbar_position = 'vertical leftabove'
let g:tagbar_width = max([25, winwidth(0) / 5])

" christoomey/vim-system-copy
let g:system_copy_enable_osc52 = 1
if has('win32') && executable('powershell')
    " force cmd.exe to use utf-8 encoding
    " https://stackoverflow.com/questions/57131654/using-utf-8-encoding-chcp-65001-in-command-prompt-windows-powershell-window
    call system('chcp 65001')
    " https://github.com/christoomey/vim-system-copy/pull/35#issue-557371087
    let g:system_copy#paste_command='powershell "Get-Clipboard"'
endif

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
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
if executable('rg')
    set grepprg=rg\ --color=never\ --hidden
    let g:ctrlp_user_command = 'rg %s --files --color=never --hidden --glob=!.git/ --glob ""'
elseif executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore .git -g ""'
else
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
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
set cursorline

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
" mouse will still work beyond the 223rd col if vim supports mouse-sgr
" https://stackoverflow.com/a/19253251/15283141
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

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

" function to run a shell
function! OpenShell(shell_id)
    if has('terminal')
        execute('FloatermToggle #'.a:shell_id)
    else
        execute('VimShellPop')
    endif
endfunction

" allow toggling between local and default mode
" https://vim.fandom.com/wiki/Toggle_between_tabs_and_spaces
function! TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunction

" test the startup time of Vim
function! TimingVimStartup(sorted)
    let l:cmd = ''
    if has('timers') && has ('terminal')
        let l:cmd = 'StartupTime --tries 10'
        if a:sorted == 0
            let l:cmd .= ' --no-sort'
        endif
    else
        let l:cmd = 'StartupTime'
    endif
    execute(l:cmd)
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

" functional hotkeys for plugins
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :<C-U>call OpenShell(v:count1)<CR>
nnoremap <silent> <F4> :UndotreeToggle<CR>
nnoremap <silent> <F5> :AirlineToggle<CR>
nnoremap <silent> <F7> :YRShow<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :CtrlP<CR>
nnoremap <C-F9> :CtrlPClearCache<CR>

inoremap <silent> <F2> <Esc>:NERDTreeToggle<CR>
inoremap <silent> <F3> <Esc>:<C-U>call OpenShell(v:count1)<CR>
inoremap <silent> <F4> <Esc>:UndotreeToggle<CR>
inoremap <silent> <F5> <Esc>:AirlineToggle<CR>
inoremap <silent> <F7> <Esc>:YRShow<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR>
inoremap <silent> <F9> <Esc>:CtrlP<CR>
inoremap <C-F9> <Esc>:CtrlPClearCache<CR>a

if has('terminal')
    tnoremap <silent> <F3> <C-W>:FloatermHide<CR>
endif

" quickly edit this config file
nnoremap <leader>ve :tabnew $MYVIMRC<CR>
" quickly save and source this config file
nmap <leader>vs :wa<Bar>so $MYVIMRC<CR>
" plugins
nmap <leader>vi <leader>vs:PlugInstall<CR>
nmap <leader>vc <leader>vs:PlugClean<CR>
nmap <leader>vu <leader>vs:PlugUpdate<CR>
" test vim startup time
nnoremap <leader>vt :call TimingVimStartup(1)<CR>
nnoremap <leader>vT :call TimingVimStartup(0)<CR>

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

" christoomey/vim-system-copy
nmap cy <Plug>SystemCopy
xmap cy <Plug>SystemCopy
nmap cY <Plug>SystemCopyLine
nmap cp <Plug>SystemPaste
xmap cp <Plug>SystemPaste
nmap cP <Plug>SystemPasteLine
