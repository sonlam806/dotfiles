call plug#begin('~/.vim/plugged')

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" Theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'drewtempelmeyer/palenight.vim'

" Spell checker
Plug 'lewis6991/spellsitter.nvim'
" hightlight todo
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'preservim/nerdcommenter'

" Status line
Plug 'hoob3rt/lualine.nvim'
" Buffer tab
Plug 'akinsho/bufferline.nvim'
" Bracket pair
Plug 'windwp/nvim-autopairs'
" Indent line
Plug 'lukas-reineke/indent-blankline.nvim'
" Comment
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Find files, buffers, grep
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'APZelos/blamer.nvim'

" Terminal
Plug 'Lenovsky/nuake'
Plug 'voldikss/vim-floaterm'
"Auto rename tag
Plug 'andrewradev/tagalong.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'b3nj5m1n/kommentary'

" React
Plug 'pangloss/vim-javascript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'


" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]


call plug#end()

" -- UI
syntax on
set cursorline
colorscheme palenight 
set background=dark
let g:airline_theme='palenight'
syntax enable
set nocompatible

"colorscheme gruvbox
" lua require('onedark').setup()

" Common key mapping 
" vim navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
" exit insert mode
inoremap jk <ESC>
nnoremap <ESC> :noh<CR>
" map leader key to Spacebar
let mapleader=" "
" Ctr + S to save the file. Magic!!!
noremap <silent> <C-S>     :w<CR>
vnoremap <silent> <C-S>    <C-C>:w<CR>
inoremap <silent> <C-S>    <C-O>:w<CR>

" NerdCommenter
filetype plugin on

set mouse=a
set number
set termguicolors 
" On pressing tab, insert 2 spaces
set expandtab
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" Copy/Paste from clipboard
set clipboard=unnamedplus

" Restart Neovim without quiting
inoremap <C-r> :source $MYVIMRC<CR>
nnoremap <C-r> :source $MYVIMRC<CR>

" Nvim tree
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Commenter
let g:NERDCreateDefaultMappings = 1

" Bufferline
nnoremap <TAB> :BufferLineCycleNext<CR>
nnoremap <S-TAB> :BufferLineCyclePrev<CR>

nnoremap <leader>fh <cmd>:Telescope help_tags<cr>

"
" LUA zone
" lua require('onedark').setup()
lua require('plugin/nvim-tree')
lua require('plenary')
" lua require('plugin/telescope')
lua require('plugin/lualine/init')
lua require('plugin/gitsigns')
lua require('plugin/bufferline')
lua require('plugin/tokyonight')
lua require('nvim-autopairs').setup{}
lua require('spellsitter').setup{}
lua require('todo-comments').setup{}

" Gitgutter
let g:gitgutter_enabled = 1 

" Nuake terminal
nnoremap <C-t> :Nuake<CR>
inoremap <C-t> <C-\><C-n>:Nuake<CR>
tnoremap <C-t> <C-\><C-n>:Nuake<CR>
" FloatTerm
let g:floaterm_keymap_new    = '<F5>'
let g:floaterm_keymap_prev   = '<F6>'
let g:floaterm_keymap_next   = '<F7>'
let g:floaterm_keymap_toggle = '<F8>'


au VimEnter * :Gitsigns toggle_current_line_blame<CR>

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
nnoremap <silent> K :call CocAction('doHover')<CR>
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nmap <leader>rn <Plug>(coc-rename)


inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-k>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-j>"

" ############### PRETTIER #################
let g:prettier#config#jsx_single_quote = 'true'
let g:prettier#config#print_width = '80'
let g:prettier#config#bracket_spacing = 'true'

" ############### FZF #################
nnoremap <leader>ff :Files<CR>
nnoremap <C-p> :Files<CR>
inoremap <C-p> :Files<CR>

" Auto closing tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'

" ############### GIT #################
let g:blamer_enabled = 1
