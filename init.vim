" Neovim Config File
" Default Location: ~/.config/nvim/init.vim

" *************************************************************************
" presettings
" *************************************************************************

set encoding=utf8

" *************************************************************************
" nvim plugins
" *************************************************************************

let GITHUB_RAW = 'https://raw.fastgit.org/'
let GITHUB_SITE = 'https://hub.fastgit.xyz/'

" download the plugin manager if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    echo 'Downloading plugin manager ...'
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs '.GITHUB_RAW.'junegunn/vim-plug/master/plug.vim && echo "Download successful." || echo "Download failed." '
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" color schemes
Plug GITHUB_SITE.'rafamadriz/neon'

" mostly used
Plug GITHUB_SITE.'kyazdani42/nvim-tree.lua'
Plug GITHUB_SITE.'vim-airline/vim-airline'
Plug GITHUB_SITE.'akinsho/toggleterm.nvim'
Plug GITHUB_SITE.'mbbill/undotree'
Plug GITHUB_SITE.'preservim/tagbar'

" more convenience
Plug GITHUB_SITE.'luochen1990/rainbow'
Plug GITHUB_SITE.'itchyny/vim-cursorword.git'
Plug GITHUB_SITE.'ntpeters/vim-better-whitespace'
Plug GITHUB_SITE.'lukas-reineke/indent-blankline.nvim'
Plug GITHUB_SITE.'windwp/nvim-autopairs'
Plug GITHUB_SITE.'tpope/vim-surround'
Plug GITHUB_SITE.'airblade/vim-rooter'
Plug GITHUB_SITE.'junegunn/vim-peekaboo'
Plug GITHUB_SITE.'preservim/nerdcommenter'
Plug GITHUB_SITE.'vim-scripts/YankRing.vim'
Plug GITHUB_SITE.'farmergreg/vim-lastplace'

" finders
Plug GITHUB_SITE.'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug GITHUB_SITE.'ibhagwan/fzf-lua', {'branch': 'main'}

" LSP related
Plug GITHUB_SITE.'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug GITHUB_SITE.'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug GITHUB_SITE.'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug GITHUB_SITE.'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug GITHUB_SITE.'L3MON4D3/LuaSnip' " Snippets plugin
Plug GITHUB_SITE.'ray-x/lsp_signature.nvim' " Function signature

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

" [rafamadriz/neon]
let g:neon_style = "dark"
let g:neon_italic_keyword = 1
let g:neon_italic_function = 1
let g:neon_transparent = 1
colorscheme neon

" [kyazdani42/nvim-tree.lua]
" https://github.com/kyazdani42/nvim-tree.lua
lua << EOF
require("nvim-tree").setup {
    view = {
        -- show windows on the right side
        side = "right",
    },
    renderer = {
        icons = {
            -- only show folder arrow symbols
            show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = false,
            },
            -- specify the folder arrow symbols
            glyphs = {
                folder = {
                    arrow_closed = '+',
                    arrow_open = '-',
                },
            },
        },
        indent_markers = {
            enable = true,
        },
    },
}
EOF

" [akinsho/toggleterm.nvim]
" https://github.com/akinsho/toggleterm.nvim
lua << EOF
require("toggleterm").setup()
EOF

" [preservim/tagbar]
let g:tagbar_position = 'vertical leftabove'
let g:tagbar_width = max([25, winwidth(0) / 5])

" [rainbow/luochen1990]
let g:rainbow_active = 1

" [lukas-reineke/indent-blankline.nvim]
" https://github.com/lukas-reineke/indent-blankline.nvim
lua << EOF
require("indent_blankline").setup {}
EOF

" [vim-scripts/YankRing.vim]
" to avoid <C-p> collision with the ctrlp plugin
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'
" save yankring history in this dir
let yankring_path=expand(stdpath("data")."/yankring-dir")
if !isdirectory(yankring_path)
    call mkdir(yankring_path, "", 0700)
endif
let g:yankring_history_dir = yankring_path

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

" [ibhagwan/fzf-lua]
" https://github.com/ibhagwan/fzf-lua
lua << EOF
require('fzf-lua').setup {}
EOF

" [neovim/nvim-lspconfig] auto-completion settings
" https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
nnoremap <silent> <F2> :NvimTreeToggle<CR>
nnoremap <silent> <F3> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent> <F4> :UndotreeToggle<CR>
nnoremap <silent> <F5> :AirlineToggle<CR>
nnoremap <silent> <F7> :YRShow<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :FzfLua<CR>

inoremap <silent> <F2> <Esc>:NvimTreeToggle<CR>
inoremap <silent> <F3> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent> <F4> <Esc>:UndotreeToggle<CR>
inoremap <silent> <F5> <Esc>:AirlineToggle<CR>
inoremap <silent> <F7> <Esc>:YRShow<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR>
nnoremap <silent> <F9> :FzfLua<CR>

tnoremap <silent> <F3> <Cmd>exe v:count1 . "ToggleTerm"<CR>
tnoremap <silent> <F9> <Esc>

" toggle list char and indentation mark
inoremap <leader>l <Esc>:set list!<Bar>IndentBlanklineToggle<CR>a
nnoremap <leader>l :set list!<Bar>IndentBlanklineToggle<CR>

" toggle paste mode
inoremap <leader>p <Esc>:set paste!<CR>a
nnoremap <leader>p :set paste!<CR>

" toggle tab/spaces
inoremap <leader>t <Esc>:call TabToggle()<CR>a
nnoremap <leader>t :call TabToggle()<CR>

" auto formatting
vnoremap <leader>f :lua vim.lsp.buf.range_formatting()<CR>
inoremap <leader>F <Esc>:lua vim.lsp.buf.formatting()<CR>a
nnoremap <leader>F :lua vim.lsp.buf.formatting()<CR>

" strip trailing whitespaces
inoremap <leader>s <Esc>:StripWhitespace<CR>a
nnoremap <leader>s :StripWhitespace<CR>

" search the word under the cursor
inoremap <leader>a <Esc>:FzfLua grep_cword<CR>
nnoremap <leader>a :FzfLua grep_cword<CR>
" search the given word
inoremap <leader>A <Esc>:FzfLua live_grep<CR>
nnoremap <leader>A :FzfLua live_grep<CR>
