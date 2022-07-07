set nocompatible              " be iMproved, required
filetype off                  " required

set backspace=indent,eol,start
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
set ruler
set ignorecase
set smartcase
set number relativenumber
set clipboard+=unnamedplus
set updatetime=100
" more natural splits
set splitbelow
set splitright

syntax on
set hidden
set termguicolors

set list
set listchars=tab:꜔-,trail:·,nbsp:⎵

set cmdheight=2
set shortmess=aFc

" folds
" set foldmethod=indent
" set foldcolumn=2
" set foldlevelstart=99

" netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20


let g:ale_disable_lsp = 1

" Fzf
set rtp+=/usr/local/opt/fzf

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'djoshea/vim-autoread'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'groenewege/vim-less'
Plug 'ap/vim-css-color'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'digitaltoad/vim-pug'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" ---- colorscheme --------
Plug 'tomasiser/vim-code-dark'
Plug 'danilo-augusto/vim-afterglow'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" ---------- LSP ----------
" Plug 'neovim/nvim-lspconfig'
" Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
" Plug 'nvim-lua/plenary.nvim'
call plug#end()

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Color scheme
" set background=dark
colorscheme codedark
" colorscheme afterglow
" colorscheme onehalfdark

" >>>>> SHORTCUTS
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <leader>p :Files<CR>

nnoremap <silent> <C-C>c :bp<CR>:bd # <CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader><Tab> <C-W><C-W>

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" <<<<< SHORTCUTS


let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }


" >>>>> LINTER
" use eslint_d as executable to speed-up linting
let g:ale_javascript_eslint_executable = 'eslint_d --cache --cache-location ~/.eslintcache/'

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
" edit and use this function to customize status bar
" <<<<< LINTER
" set statusline+=%{LinterStatus()}%{coc#status()}%{get(b:,'coc_current_function','')}

let g:buffergator_viewport_split_policy = "B"
let g:buffergator_hsplit_size = 10

" FZF
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
let $FZF_DEFAULT_COMMAND='rg --files'
