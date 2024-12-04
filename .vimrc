" *************************************************************************
" presettings
" *************************************************************************

" ASCII art -- https://patorjk.com/software/taag/#p=display&f=Small&t=MY-VIMRC
let MY_VIMRC_WELCOME = "\n"
            \ .' __  ____   __ __   _____ __  __ ___  ___ '."\n"
            \ .'|  \/  \ \ / /_\ \ / /_ _|  \/  | _ \/ __|'."\n"
            \ .'| |\/| |\ V /___\ V / | || |\/| |   / (__ '."\n"
            \ .'|_|  |_| |_|     \_/ |___|_|  |_|_|_\\___|'."\n"

" vim data directory
if has('win32')
    let DATA_DIR = expand($HOME.'/vimfiles')
else
    let DATA_DIR = expand($HOME.'/.vim')
endif

" only use basic functions of my-vimrc -- 1:true 0:false
let MY_VIMRC_BASIC = 0

" mirrors for github site & github raw
let GITHUB_SITE = 'https://ghp.ci/https://github.com/'
"let GITHUB_SITE = 'https://www.ghproxy.cn/https://github.com/'
"let GITHUB_SITE = 'https://github.site/'
"let GITHUB_SITE = 'https://github.store/'
"let GITHUB_SITE = 'https://github.com/'
let GITHUB_RAW = 'https://ghp.ci/https://raw.githubusercontent.com/'
"let GITHUB_RAW = 'https://www.ghproxy.cn/https://raw.githubusercontent.com/'
"let GITHUB_RAW = 'https://raw.github.site/'
"let GITHUB_RAW = 'https://raw.github.store/'
"let GITHUB_RAW = 'https://raw.githubusercontent.com/'

" *************************************************************************
" basic settings
" *************************************************************************

set encoding=utf8
set nocompatible

if has('termguicolors')
    set termguicolors
endif

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
set ignorecase
set smartcase

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
let s:undo_dir = expand(DATA_DIR.'/undo-dir')
if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, "p", 0700)
endif
let &undodir = s:undo_dir
set undofile

" *************************************************************************
" basic functions
" *************************************************************************

" a wrapper of input() but without the retval
function! s:ShowDialog(text)
    if !has('gui_running')
        "TODO: a trick only to keep the text shown on win32
        if has('win32')
            new | redraw | quit
            echo "\n"
        endif
        call input(a:text)
    else
        call inputdialog(a:text)
    endif
endfunction

" verify the first maxline of the downloaded file with the pattern
" retval: 0 -- good;
"        -1 -- file not readable;
"        -2 -- pattern not found in the first maxline of file
function! s:VerifyDownload(filename, pattern, maxline)
    if !filereadable(a:filename)
        echo '[my-vimrc] Download failed. "'.a:filename.'" is not found or not readable.'
        return -1
    endif

    let lines = readfile(a:filename)
    let line_count = len(lines)
    let i = 0
    while i < line_count && i < a:maxline
        if lines[i] =~ a:pattern
            return 0
        endif
        let i += 1
    endwhile
    echo '[my-vimrc] Verification failed. "'.a:filename.'" might be corrupted.'
    return -2
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

" *************************************************************************
" basic filetypes
" *************************************************************************

" scons
augroup scons_ft
  au!
  autocmd bufnewfile,bufread sconstruct set filetype=python
augroup end

" *************************************************************************
" basic keymaps
" *************************************************************************

" quickly edit this config file
nnoremap <leader>ve :tabnew $MYVIMRC<CR>
" quickly save and source this config file
nnoremap <leader>vs :wa<Bar>so $MYVIMRC<CR>

" toggle paste mode
nnoremap <leader>p :set paste!<CR>

" toggle list char
nnoremap <leader>l :set list!<CR>

" toggle tab/spaces
nnoremap <leader>t :call TabToggle()<CR>

" switch between tabs
nnoremap <leader>} :tabnext<CR>
nnoremap <leader>{ :tabprevious<CR>

" switch between buffers
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>

" *************************************************************************
" plugin manager
" *************************************************************************

" only use basic functions of my-vimrc
if MY_VIMRC_BASIC != 0
    finish
endif

" first we check for git; finish execution if no git is found
if !executable('git')
    call s:ShowDialog('[my-vimrc] The "git" command is missing. '
                \ .'Only basic functions are available.'
                \ ."\nPress ENTER to continue\n")
    finish
endif

let AUTOLOAD_DIR = expand(DATA_DIR.'/autoload')
let PLUGIN_MANAGER_PATH = expand(AUTOLOAD_DIR.'/plug.vim')
let PLUGIN_MANAGER_URL = GITHUB_RAW.'/junegunn/vim-plug/master/plug.vim'
let PLUGIN_MANAGER_PATTERN = ':PlugInstall'

" download the plugin manager if not installed
silent if s:VerifyDownload(PLUGIN_MANAGER_PATH, PLUGIN_MANAGER_PATTERN, 1000) != 0
    " welcome our beloved user
    call s:ShowDialog(MY_VIMRC_WELCOME."\n[my-vimrc] Thank you for using my-vimrc!\n"
                \ ."Press ENTER to download the plugin manager\n")

    " try different ways to download the plugin manager
    if has('win32') && executable('powershell')
        silent execute '!powershell "iwr -useb '.PLUGIN_MANAGER_URL.' |` '
                    \ .'ni '.PLUGIN_MANAGER_PATH.' -Force"'
    elseif has('win32') && executable('certutil')
        silent execute '!(if not exist "'.AUTOLOAD_DIR.'" mkdir "'.AUTOLOAD_DIR.'")'
                    \ .'&& certutil -urlcache -split -f "'.PLUGIN_MANAGER_URL.'"'
                    \ .' "'.PLUGIN_MANAGER_PATH.'"'
    elseif executable('wget')
        silent execute '!mkdir -p '.AUTOLOAD_DIR.' '
                    \ .'&& wget -O '.PLUGIN_MANAGER_PATH.' '.PLUGIN_MANAGER_URL.' '
                    \ .'&& echo "Download successful." || echo "Download failed." '
    elseif executable('curl')
        silent execute '!curl -fLo '.PLUGIN_MANAGER_PATH
                    \ .' --create-dirs '.PLUGIN_MANAGER_URL.' '
                    \ .'&& echo "Download successful." || echo "Download failed." '
    else
        echo '[my-vimrc] No downloader available.'
    endif

    " verify the downloaded file; finish the execution if failed
    if s:VerifyDownload(PLUGIN_MANAGER_PATH, PLUGIN_MANAGER_PATTERN, 1000) != 0
        call s:ShowDialog('[my-vimrc] Unable to download the plugin manager. '
                    \ .'Only basic functions are available. '
                    \ ."\nPlease manually download the plugin manager from "
                    \ .'"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
                    \ .' and save it as "'.PLUGIN_MANAGER_PATH.'"'
                    \ ."\nPress ENTER to continue\n")
        finish
    else
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
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
Plug GITHUB_SITE.'NewComer00/ack.vim', { 'branch': 'patch-1' }
Plug GITHUB_SITE.'vim-scripts/YankRing.vim'

" --------------------
" more convenience
" --------------------
Plug GITHUB_SITE.'luochen1990/rainbow'
Plug GITHUB_SITE.'itchyny/vim-cursorword.git'
Plug GITHUB_SITE.'ntpeters/vim-better-whitespace'
Plug GITHUB_SITE.'gosukiwi/vim-smartpairs'
Plug GITHUB_SITE.'tpope/vim-surround'
Plug GITHUB_SITE.'airblade/vim-rooter'
Plug GITHUB_SITE.'junegunn/vim-peekaboo'
Plug GITHUB_SITE.'tpope/vim-commentary'
Plug GITHUB_SITE.'farmergreg/vim-lastplace'
Plug GITHUB_SITE.'unblevable/quick-scope'
" system clipboard
if has('patch-8.2.1337')
    " https://github.com/vim/vim/issues/6591
    Plug GITHUB_SITE.'ojroques/vim-oscyank'
    Plug GITHUB_SITE.'christoomey/vim-system-copy'
else
    Plug GITHUB_SITE.'ojroques/vim-oscyank', { 'commit': '14685fc' }
    Plug GITHUB_SITE.'christoomey/vim-system-copy', { 'commit': '1e5afc4' }
endif
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
if exists('plugs') && has_key(plugs, 'vim-colorschemes')
            \ && filereadable(plugs['vim-colorschemes']['dir'].'/colors/molokai.vim')
    colorscheme molokai
endif

" preservim/nerdtree
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMouseMode=2
" disable the original file explorer
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" lazy load nerdtree when open a directory
" https://github.com/junegunn/vim-plug/issues/424#issuecomment-189343357
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

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
if executable('rg')
    let g:ackprg = 'rg --vimgrep --hidden --glob=!.git/'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep --hidden --ignore .git'
endif

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
" using F9 to toggle Ctrlp
let g:ctrlp_prompt_mappings = { 'PrtExit()': ['<F9>','<esc>','<c-c>','<c-g>'] }
if executable('rg')
    set grepprg=rg\ --color=never\ --hidden
    let g:ctrlp_user_command = 'rg %s --files --color=never --hidden --glob=!.git/'
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
let s:yankring_dir = expand(DATA_DIR.'/yankring-dir')
if !isdirectory(s:yankring_dir)
    call mkdir(s:yankring_dir, "p", 0700)
endif
let g:yankring_history_dir = s:yankring_dir

" unblevable/quick-scope
let g:qs_buftype_blacklist = ['terminal', 'nofile']
let g:qs_filetype_blacklist = ['dashboard', 'startify']

" google/vim-maktaba
if exists('*maktaba#syscall#SetUsableShellRegex')
    " work-around for windows
    call maktaba#syscall#SetUsableShellRegex('\v^/bin/sh|cmd|cmd\.exe|command\.com$')
endif

" google/vim-codefmt
if exists('*maktaba#plugin#GetOrInstall') && exists('*glaive#Install')
    call glaive#Install()
endif

" *************************************************************************
" extra functions
" *************************************************************************

" function to run a shell
function! OpenShell(shell_id)
    if has('terminal')
        execute('FloatermToggle #'.a:shell_id)
    else
        execute('VimShellPop')
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

" *************************************************************************
" extra keymaps
" *************************************************************************

" functional hotkeys for plugins
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :<C-U>call OpenShell(v:count1)<CR>
nnoremap <silent> <F4> :UndotreeToggle<CR>
nnoremap <silent> <F5> :AirlineToggle<CR>
nnoremap <silent> <F7> :YRShow<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :CtrlP<CR>
nnoremap <S-F9> :CtrlPClearCache<CR>

inoremap <silent> <F2> <Esc>:NERDTreeToggle<CR>
inoremap <silent> <F3> <Esc>:<C-U>call OpenShell(v:count1)<CR>
inoremap <silent> <F4> <Esc>:UndotreeToggle<CR>
inoremap <silent> <F5> <Esc>:AirlineToggle<CR>
inoremap <silent> <F7> <Esc>:YRShow<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR>
inoremap <silent> <F9> <Esc>:CtrlP<CR>
inoremap <S-F9> <Esc>:CtrlPClearCache<CR>a

if has('terminal')
    tnoremap <silent> <F3> <C-W>:FloatermHide<CR>
endif

" plugin manager shortcuts
nnoremap <leader>vi :wa<Bar>silent! so $MYVIMRC<CR>:PlugInstall<CR>
nnoremap <leader>vc :wa<Bar>silent! so $MYVIMRC<CR>:PlugClean<CR>
nnoremap <leader>vu :wa<Bar>silent! so $MYVIMRC<CR>:PlugUpdate<CR>
" test vim startup time
nnoremap <leader>vt :call TimingVimStartup(1)<CR>
nnoremap <leader>vT :call TimingVimStartup(0)<CR>

" google auto format
nnoremap <leader>f :FormatLines<CR>
nnoremap <leader>F :FormatCode<CR>

" strip trailing whitespaces
nnoremap <leader>s :StripWhitespace<CR>

" search the word under the cursor
nnoremap <leader>a :Ack!<CR>
" search the given word
nnoremap <leader>A :Ack!<Space>

" toggle highlighting for unblevable/quick-scope
nmap <leader>q <plug>(QuickScopeToggle)
xmap <leader>q <plug>(QuickScopeToggle)

" christoomey/vim-system-copy
nmap cy <Plug>SystemCopy
xmap cy <Plug>SystemCopy
nmap cY <Plug>SystemCopyLine
nmap cp <Plug>SystemPaste
xmap cp <Plug>SystemPaste
nmap cP <Plug>SystemPasteLine
