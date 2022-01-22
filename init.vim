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

" Vim fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Vim autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim ANTLR
Plug 'jrozner/vim-antlr'

" Bracket colorizer
Plug 'junegunn/rainbow_parentheses.vim' 

" Vim auto-pairs
Plug 'jiangmiao/auto-pairs'

" Vim close-tag
Plug 'alvan/vim-closetag'

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
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab


" Tab pages
" Mapping key for moving between tabs
nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>

" Mapping key for moving current tab position
nnoremap <silent> <A-left> :tabm -1<CR>
nnoremap <silent> <A-right> :tabm +1<CR>

" Mapping key for tab focus toggling
let notabs = 0
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" Mapping key for opening and closing tabs
nnoremap <C-t> :tabe<CR>
nnoremap <C-q> :tab close<CR>


" Set colorscheme
syntax enable
autocmd VimEnter * ++nested colorscheme nord

" Dark gruvbox background
set background=dark
" Transparent background for gruvbox
" autocmd VimEnter * hi Normal ctermbg=none


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
" NERDTree position
let g:NERDTreeWinPos = "right"

" Mapping keys for NERDTree toggling
nmap <F6> :NERDTreeToggle<CR>


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


" FZF
" Mapping keys for fzf toggling
nnoremap <silent> <C-p> :Files<CR>

" Find files in project
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


" COC
" Coc extensions
let g:coc_global_extensions = [
    \ 'coc-prettier',
    \ 'coc-highlight',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-tsserver',
    \ 'coc-yaml',
    \ 'coc-clangd',
    \ 'coc-python',
    \ 'coc-flutter',
    \ 'coc-sql',
    \ 'coc-cmake',
    \ 'coc-markdownlint',
    \ 'coc-markdown-preview-enhanced',
    \ 'coc-webview',
    \ ]


