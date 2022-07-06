" This is my Neovim configuration file


" Vim-plug session
call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

" Vim NERDTree
Plug 'preservim/nerdtree'

" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'

" Vim zen mode
Plug 'junegunn/goyo.vim'

" Vim limelight
Plug 'junegunn/limelight.vim'

" Vim terminal
Plug 'akinsho/toggleterm.nvim'

" Git
Plug 'tpope/vim-fugitive'

" Vim fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Vim autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Format supports
Plug 'junegunn/rainbow_parentheses.vim' 
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/flutter-tools.nvim'

" Python
Plug 'davidhalter/jedi-vim'

" Typescript
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'

" ANTLR
Plug 'jrozner/vim-antlr'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'natebosch/dartlang-snippets'

call plug#end()


" General settings
set noswapfile

" Enable text selecting with mouse
se mouse+=a

" Set line numbers
set number
set rnu

" Mapping keys with Ctrl+C, Ctrl+X and Ctrl+V shortcuts
vmap <C-c> "+y<CR>
vmap <C-x> "+x<CR>
nmap <C-v> "+gP<CR>

" Lock arrow keys
nnoremap <Left> :echo "Use H!"<CR>
nnoremap <Down> :echo "Use J!"<CR>
nnoremap <Up> :echo "Use K!"<CR>
nnoremap <Right> :echo "Use L!"<CR>


" Set cursor
" Reference chart of values:
"   Ps = 0  -> blinking block
"   Ps = 1  -> blinking block (default)
"   Ps = 2  -> steady block
"   Ps = 3  -> blinking underline
"   Ps = 4  -> steady underline
"   Ps = 5  -> blinking bar (xterm)
"   Ps = 6  -> steady bar (xterm)
" Enter Insert mode
let &t_SI="\e[6 q"
" Exit Insert mode
let &t_EI="\e[2 q"


" 4-space tabbing
" Set tab width
" filetype plugin indent on
set tabstop=4
set shiftwidth=4
" set expandtab


" Tab pages
" Mapping key for moving current tab position
nnoremap <silent> <A-left> :tabm -1<CR>
nnoremap <silent> <A-right> :tabm +1<CR>

" Mapping key for tab focus toggling
let notabs = 0
nnoremap <silent> <C-S-o> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" Mapping key for opening and closing tabs
nnoremap <C-t> :tabe<CR>
nnoremap <C-w> :tab close<CR>


" Set colorscheme
syntax enable
autocmd VimEnter * ++nested colorscheme gruvbox

" Dark gruvbox background
set background=dark
" Transparent background for gruvbox
autocmd VimEnter * hi Normal ctermbg=none
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Turn off highlight
nnoremap <C-h> :nohl<CR>


" Airline styling
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#clock#format = '%H:%M'
let g:airline_theme =  'bubblegum'

" Set powerline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' ln:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.colnr=' col:'


" NERDTree
" Position
let g:NERDTreeWinPos = "right"
" Mapping keys for NERDTree toggling
nmap <C-b> :NERDTreeToggle<CR>
" Git status
let g:NERDTreeGitStatusWithFlags = 1


" Bracket colorizer
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd FileType * RainbowParentheses


" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_paragraph_span = 0

" Mapping keys for Limelight toggle
nmap <C-l> :Limelight!!<CR>


" Goyo zen mode
" Mapping keys for Goyo toggling
nmap <C-k> :Goyo<CR>

" Limelight integration
function! s:goyo_enter()
    set number
    set rnu
    " hi Normal ctermbg=none

    Limelight

    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    " hi Normal ctermbg=none
    
    Limelight!

    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif 
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Toggleterm 


" FZF
" Mapping keys for fzf toggling
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-S-f> :FZF<CR>

" Find files in project
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


" Snippets
let g:UltiSnipsExpandTrigger = '<Nop>'
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'


" COC
" Node path
let g:coc_node_path = "/home/nhattan/.nvm/versions/node/v14.19.0/bin/node"

" Coc extensions
let g:coc_global_extensions = [
    \ 'coc-highlight',
    \ 'coc-snippets',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-emmet',
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-tsserver',
    \ 'coc-yaml',
    \ 'coc-clangd',
    \ 'coc-flutter',
    \ 'coc-pyright',
    \ 'coc-sql',
    \ 'coc-cmake',
    \ 'coc-markdownlint',
    \ 'coc-markdown-preview-enhanced',
    \ 'coc-webview',
    \ ]

" Dart & Flutter
let g:dart_format_on_save = 1
let g:dart_trailing_comma_indent = v:true
let g:dartfmt_options = ['--fix', '--line-length 120']
"au BufNewFile,BufRead *.dart
"    \ set tabstop=2 |
"    \ set softtabstop=2 noexpandtab |
"    \ set shiftwidth=2 |
"    \ set autoindent |
"    \ set fileformat=unix

" Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=0 noexpandtab |
    \ set shiftwidth=4 |
    \ set autoindent |
    \ set fileformat=unix
let NERDTreeIgnore=['\.pyc$', '\~$']

" Typescripts
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" ANTLR4
au BufRead,BufNewFile *.g4 set filetype=antlr4


