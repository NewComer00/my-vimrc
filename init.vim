" *************************************************************************
" presettings
" *************************************************************************

set encoding=utf8

" *************************************************************************
" nvim plugins
" *************************************************************************

let GITHUB_SITE = 'https://gh.con.sh/https://github.com/'
"let GITHUB_SITE = 'https://mirror.ghproxy.com/https://github.com/'
"let GITHUB_SITE = 'https://hub.fastgit.xyz/'
"let GITHUB_SITE = 'https://github.com/'
let GITHUB_RAW = 'https://mirror.ghproxy.com/https://raw.githubusercontent.com/'
"let GITHUB_RAW = 'https://raw.fastgit.org/'
"let GITHUB_RAW = 'https://raw.githubusercontent.com/'

" download the plugin manager if not installed
let AUTOLOAD_DIR = stdpath('config').'/autoload'
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
" color scheme
" --------------------
Plug GITHUB_SITE.'folke/tokyonight.nvim', { 'branch': 'main' }

" --------------------
" mostly used
" --------------------
Plug GITHUB_SITE.'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug GITHUB_SITE.'nvim-lualine/lualine.nvim'
Plug GITHUB_SITE.'akinsho/toggleterm.nvim'
Plug GITHUB_SITE.'mbbill/undotree'
Plug GITHUB_SITE.'preservim/tagbar', { 'on': 'TagbarToggle' }
Plug GITHUB_SITE.'vim-scripts/YankRing.vim'
" finder
Plug GITHUB_SITE.'nvim-lua/plenary.nvim'
Plug GITHUB_SITE.'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" debugger
Plug GITHUB_SITE.'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

" --------------------
" more convenience
" --------------------
Plug GITHUB_SITE.'ggandor/leap.nvim'
Plug GITHUB_SITE.'ntpeters/vim-better-whitespace'
Plug GITHUB_SITE.'windwp/nvim-autopairs'
Plug GITHUB_SITE.'kylechui/nvim-surround'
Plug GITHUB_SITE.'notjedi/nvim-rooter.lua'
Plug GITHUB_SITE.'junegunn/vim-peekaboo'
Plug GITHUB_SITE.'terrortylor/nvim-comment'
Plug GITHUB_SITE.'ethanholz/nvim-lastplace'
" system clipboard
Plug GITHUB_SITE.'ojroques/vim-oscyank'
Plug GITHUB_SITE.'christoomey/vim-system-copy'
" git related
Plug GITHUB_SITE.'tpope/vim-fugitive'
Plug GITHUB_SITE.'junegunn/gv.vim'
" neovim performance
Plug GITHUB_SITE.'lewis6991/impatient.nvim'
Plug GITHUB_SITE.'dstein64/vim-startuptime'

" --------------------
" highlight & appearance
" --------------------
Plug GITHUB_SITE.'nvim-treesitter/nvim-treesitter'
Plug GITHUB_SITE.'p00f/nvim-ts-rainbow'
Plug GITHUB_SITE.'luochen1990/rainbow'
Plug GITHUB_SITE.'nyngwang/murmur.lua', { 'commit': 'b7fc2b3' }
Plug GITHUB_SITE.'lukas-reineke/indent-blankline.nvim'
Plug GITHUB_SITE.'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug GITHUB_SITE.'nvim-zh/colorful-winsep.nvim'

" --------------------
" LSP related
" --------------------
Plug GITHUB_SITE.'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug GITHUB_SITE.'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug GITHUB_SITE.'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug GITHUB_SITE.'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug GITHUB_SITE.'L3MON4D3/LuaSnip' " Snippets plugin
Plug GITHUB_SITE.'ray-x/lsp_signature.nvim' " Function signature
Plug GITHUB_SITE.'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' " Toggle LSP diagnostics

call plug#end()

" *************************************************************************
" Language Server Protocol (LSP) server configs
" *************************************************************************

" [neovim/nvim-lspconfig]
" https://github.com/neovim/nvim-lspconfig
lua << EOF
-- register your installed LSP server here
MY_LSP_SERVER_LIST = {
    -- for example:
    -- "pylsp",
    -- "clangd",
}
-- find out LSP server for each language :
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps

-- my custom config function,
-- only take effect on buffers with an active language server
MY_CUSTOM_ON_ATTACH = function(client)
    -- hotkeys for LSP service
    vim.keymap.set('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vim.keymap.set('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
end
EOF

" *************************************************************************
" plugin configs
" *************************************************************************

" [lewis6991/impatient.nvim]
lua require('impatient')

" [folke/tokyonight.nvim]
lua << EOF
require("tokyonight").setup({
    style = "night",
    light_style = "day",
    transparent = false,
    terminal_colors = true,
})
EOF
colorscheme tokyonight

" [preservim/nerdtree]
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

" [akinsho/toggleterm.nvim]
" https://github.com/akinsho/toggleterm.nvim
lua << EOF
require("toggleterm").setup{
    on_open = function()
        if vim.fn.has 'win32' == 1 then
            vim.cmd([[startinsert]])
        end
    end,
}
EOF

" [preservim/tagbar]
let g:tagbar_position = 'vertical leftabove'
let g:tagbar_width = max([25, winwidth(0) / 5])

" [nvim-lualine/lualine.nvim]
lua << END
require('lualine').setup{
    options = {
        theme = 'auto',
        section_separators = '',
        component_separators = '|',
        icons_enabled = false
    }
}
END

" [vim-scripts/YankRing.vim]
" make it compatible for neovim
" https://github.com/neovim/neovim/issues/2642#issuecomment-218232937
let g:clipboard = {} " https://github.com/neovim/neovim/issues/9570
let g:yankring_clipboard_monitor = 0
" to avoid <C-p> collision with the ctrlp plugin
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'
" save yankring history in this dir
let yankring_path=expand(stdpath("data")."/yankring-dir")
if !isdirectory(yankring_path)
    call mkdir(yankring_path, "", 0700)
endif
let g:yankring_history_dir = yankring_path

" [nvim-telescope/telescope.nvim]
lua << EOF
-- https://www.reddit.com/r/neovim/comments/pzxw8h/telescope_quit_on_first_single_esc/
local actions = require("telescope.actions")
require('telescope').setup{
    defaults = {
        mappings = {
            n = {
                ["<F9>"] = actions.close,
            },
            i = {
                ["<F9>"] = actions.close,
                ["<RightMouse>"] = actions.close,
                ["<LeftMouse>"] = actions.select_default,
                ["<ScrollWheelDown>"] = actions.move_selection_next,
                ["<ScrollWheelUp>"] = actions.move_selection_previous,
            },
        },
    },
}
EOF

" [sakhnik/nvim-gdb]
" https://github.com/sakhnik/nvim-gdb
" disable default keymaps
let g:nvimgdb_disable_start_keymaps = 1
" set debugger keymaps
function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>G
endfunction
nnoremap <M-r> :GdbRun<CR>
let g:nvimgdb_config_override = {
  \ 'key_next': '<M-n>',
  \ 'key_step': '<M-s>',
  \ 'key_finish': '<M-f>',
  \ 'key_continue': '<M-c>',
  \ 'key_until': '<M-t>',
  \ 'key_breakpoint': '<M-b>',
  \ 'key_quit': '<M-q>',
  \ 'key_eval': '<M-e>',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }

" [ggandor/leap.nvim]
lua << EOF
require('leap').add_default_mappings()
EOF

" [ntpeters/vim-better-whitespace]
" https://github.com/ntpeters/vim-better-whitespace/issues/158
augroup vimrc
  autocmd TermOpen * :DisableWhitespace
augroup END

" [windwp/nvim-autopairs] with nvim-cmp
" https://github.com/windwp/nvim-autopairs
lua << EOF
require("nvim-autopairs").setup {}
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)
EOF

" [kylechui/nvim-surround]
lua << EOF
require("nvim-surround").setup()
EOF

" [notjedi/nvim-rooter.lua]
lua << EOF
require'nvim-rooter'.setup()
EOF

" [terrortylor/nvim-comment]
lua << EOF
require('nvim_comment').setup({
    comment_empty = false
})
EOF

" [ethanholz/nvim-lastplace]
lua << EOF
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}
EOF

" [christoomey/vim-system-copy]
let g:system_copy_enable_osc52 = 1
if has('win32') && executable('powershell')
    " force cmd.exe to use utf-8 encoding
    " https://stackoverflow.com/questions/57131654/using-utf-8-encoding-chcp-65001-in-command-prompt-windows-powershell-window
    call system('chcp 65001')
    " https://github.com/christoomey/vim-system-copy/pull/35#issue-557371087
    let g:system_copy#paste_command='powershell "Get-Clipboard"'
endif

" [nvim-treesitter/nvim-treesitter]
lua << EOF
for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  config.install_info.url = config.install_info.url:gsub("^https://github.com/", vim.api.nvim_get_var('GITHUB_SITE'))
end
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    -- [p00f/nvim-ts-rainbow]
    rainbow = {
        enable = true,
        extended_mode = true,
    },
}
EOF

" [nyngwang/murmur.lua]
lua << EOF
require('murmur').setup {
    max_len = 80,
    min_len = 1,
}
EOF

" [rainbow/luochen1990]
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'separately': {
\   'nerdtree': 0,
\   }
\}

" [lukas-reineke/indent-blankline.nvim]
" https://github.com/lukas-reineke/indent-blankline.nvim
lua << EOF
require("indent_blankline").setup {}
EOF

" [akinsho/bufferline.nvim]
" https://github.com/akinsho/bufferline.nvim
lua << EOF
require("bufferline").setup{
    options = {
        mode = "buffers",
        show_buffer_icons = false,
        buffer_close_icon = 'x',
        close_icon = 'X',
        left_trunc_marker = '',
        right_trunc_marker = '',
        offsets = {
            {
                filetype = "nerdtree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true
            },
            {
                filetype = "undotree",
                text = "Undo History",
                highlight = "Directory",
                separator = true
            },
            {
                filetype = "tagbar",
                text = "Tag List",
                highlight = "Directory",
                separator = true
            },
        },
    },
}
EOF

" [nvim-zh/colorful-winsep.nvim]
" https://github.com/nvim-zh/colorful-winsep.nvim
lua << EOF
require('colorful-winsep').setup({
    symbols = { "─", "│", "┌", "┐", "└", "┘" },
})
EOF

" [neovim/nvim-lspconfig] auto-completion settings
" https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(MY_LSP_SERVER_LIST) do
    lspconfig[lsp].setup {
        on_attach = MY_CUSTOM_ON_ATTACH,
        capabilities = capabilities,
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
EOF

" [ray-x/lsp_signature.nvim]
" https://github.com/ray-x/lsp_signature.nvim
lua << EOF
require "lsp_signature".setup {}
EOF

" [WhoIsSethDaniel/toggle-lsp-diagnostics.nvim]
" https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
lua << EOF
-- turn off lsp diagnostics by default
require'toggle_lsp_diagnostics'.init({ start_on = false })
EOF

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
let undodir_path=expand(stdpath("data")."/undo-dir")
if !isdirectory(undodir_path)
    call mkdir(undodir_path, "", 0700)
endif
let &undodir=undodir_path
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

" my wrapper for [sakhnik/nvim-gdb]
function! GdbStartAuto()
    let current_file_path = expand('%:p')
    let current_file_type = &filetype
    let debugger_info = [
    \   {'name':'gdb',      'filetype':['cpp','c','objcpp'],    'cmd':'GdbStart gdb -q'},
    \   {'name':'lldb',     'filetype':['cpp','c','objcpp'],    'cmd':'GdbStartLLDB lldb'},
    \   {'name':'pdb',      'filetype':['python'],              'cmd':'GdbStartPDB python3 -m pdb '.current_file_path},
    \   {'name':'bashdb',   'filetype':['sh'],                  'cmd':'GdbStartBashDB bashdb '.current_file_path},
    \   ]

    " first try to open the related debugger by current filetype
    let counter = 0
    for debugger in debugger_info
        if index(debugger['filetype'], current_file_type) >= 0
            exec(debugger['cmd'])
            break
        else
            let counter += 1
        endif
    endfor

    " if no suitable debugger for the filetype,
    " let the user decide which debugger to use
    if counter >= len(debugger_info)
        echo 'Available debuggers:'
        let debugger_number = 1
        for debugger in debugger_info
            echo '  '.string(debugger_number).'.'.debugger['name'].' '
            let debugger_number += 1
        endfor
        echo '  '.string(debugger_number).'.quit'

        "let choosen_number = input('Select a debugger: ')
        " save one keystroke by using getchar() instead of input()
        " TODO: assert len(debugger_info) < 9 when use getchar()
        echo 'Select a debugger:'
        let choosen_number = nr2char(getchar())
        let idx = choosen_number - 1
        redraw " flush the old output
        if idx >= 0 && idx < len(debugger_info)
            exec(debugger_info[idx]['cmd'])
        else
            echo 'quit'
        endif
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

" functional hotkeys for plugins
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent> <F4> :UndotreeToggle<CR>
nnoremap <silent> <F6> :call GdbStartAuto()<CR>
nnoremap <silent> <F7> :YRShow<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :Telescope find_files<CR>

inoremap <silent> <F2> <Esc>:NvimTreeToggle<CR>
inoremap <silent> <F3> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent> <F4> <Esc>:UndotreeToggle<CR>
inoremap <silent> <F6> <Esc>:call GdbStartAuto()<CR>
inoremap <silent> <F7> <Esc>:YRShow<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR>

cnoremap <silent> <F6> <C-c>

tnoremap <silent> <F3> <C-\><C-n><Cmd>exe v:count1 . "ToggleTerm"<CR>

" use <Esc> to quit terminal mode
tnoremap <Esc> <C-\><C-n>

" quickly edit this config file
nnoremap <leader>ve :tabnew $MYVIMRC<CR>
" quickly save and source this config file
nnoremap <leader>vs :wa<Bar>so $MYVIMRC<CR>
" plugin manager shortcuts
nnoremap <leader>vi :wa<Bar>silent! so $MYVIMRC<CR>:PlugInstall<CR>
nnoremap <leader>vc :wa<Bar>silent! so $MYVIMRC<CR>:PlugClean<CR>
nnoremap <leader>vu :wa<Bar>silent! so $MYVIMRC<CR>:PlugUpdate<CR>
" test vim startup time
nnoremap <leader>vt :StartupTime --tries 10<CR>
nnoremap <leader>vT :StartupTime --tries 10 --no-sort<CR>

" toggle list char and indentation mark
nnoremap <leader>l :set list!<Bar>IndentBlanklineToggle<CR>

" toggle paste mode
nnoremap <leader>p :set paste!<CR>

" toggle tab/spaces
nnoremap <leader>t :call TabToggle()<CR>

" auto formatting
nnoremap <leader>f <C-V>gq
vnoremap <leader>f gq
nnoremap <leader>F :lua vim.lsp.buf.format()<CR>

" strip trailing whitespaces
nnoremap <leader>s :StripWhitespace<CR>

" search the word under the cursor
nnoremap <leader>a :Telescope grep_string<CR>
" search the given word
nnoremap <leader>A :Telescope live_grep<CR>

" toggle LSP diagnostics
nnoremap <leader>d :ToggleDiag<CR>

" toggle pwd between the repo's root and the dir of current file
nnoremap <leader>r :RooterToggle<CR>

" switch between buffers
nnoremap <leader>] :BufferLineCycleNext<CR>
nnoremap <leader>[ :BufferLineCyclePrev<CR>
" switch between tabs
nnoremap <leader>} :tabnext<CR>
nnoremap <leader>{ :tabprevious<CR>

" system copy
nmap cy <Plug>SystemCopy
xmap cy <Plug>SystemCopy
nmap cY <Plug>SystemCopyLine
nmap cp <Plug>SystemPaste
xmap cp <Plug>SystemPaste
nmap cP <Plug>SystemPasteLine
