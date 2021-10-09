call plug#begin('~/.vim/plugged')

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" Theme
" Plug 'ful1e5/onedark.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Status line
Plug 'hoob3rt/lualine.nvim'
" Buffer tab
Plug 'akinsho/bufferline.nvim'
" Bracket pair
Plug 'windwp/nvim-autopairs'
" Find files, buffers, grep
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

" Terminal
Plug 'Lenovsky/nuake'
" Initialize plugin system
"
call plug#end()

" -- UI
colorscheme tokyonight

" Common key mapping 
" vim navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
" exit insert mode
inoremap jk <ESC>
" map leader key to Spacebar
let mapleader=" "
" Ctr + S to save the file. Magic!!!
nnoremap <D-s> :w

set mouse=a
set number
set termguicolors 
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" Nvim tree
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Bufferline
nnoremap <TAB> :BufferLineCycleNext<CR>
nnoremap <S-TAB> :BufferLineCyclePrev<CR>

nnoremap <leader>fh <cmd>:Telescope help_tags<cr>

"
" LUA zone
" lua require('onedark').setup()
lua require('plugin/nvim-tree')
lua require('plenary')
lua require('plugin/telescope')
lua require('plugin/lualine/init')
lua require('plugin/gitsigns')
lua require('plugin/bufferline')
lua require('plugin/tokyonight')
lua require('nvim-autopairs').setup{}

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>:Telescope find_files<cr>
nnoremap <leader>fg <cmd>:Telescope live_grep<cr>
nnoremap <leader>fb <cmd>:Telescope buffers<cr>

" Gitgutter
let g:gitgutter_enabled = 1 

" Nuake terminal
nnoremap <C-t> :Nuake<CR>
inoremap <C-t> <C-\><C-n>:Nuake<CR>
tnoremap <C-t> <C-\><C-n>:Nuake<CR>

au VimEnter * :Gitsigns toggle_current_line_blame<CR>
