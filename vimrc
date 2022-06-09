" This is my vim configuration file


" Vim-plug session
call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next' " OceanicNext
Plug 'tomasiser/vim-code-dark' " codedark

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


" Administrative settings
set noswapfile

" Enable text selecting with mouse
se mouse+=a

" Set line numbers
set number
set rnu

" Set split below
set splitbelow

" Set terminal size
set termwinsize=10x0

" Map Ctrl+J to open terminal
nnoremap <silent> <C-j> :bo term<CR>

" Mapping keys with Ctrl+C, Ctrl+X, Ctrl+V shortcuts
" Required vim-gtk installed
vmap <C-c> "+y<CR>
vmap <C-x> "+x<CR>
nmap <C-v> "+gP<CR>


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


" Set colorscheme
syntax enable

"if (has("termguicolors"))
"   set termguicolors
"endif

autocmd VimEnter * ++nested colorscheme nord

" Dark gruvbox background
set background=dark
" Transparent background for some color schemes
autocmd VimEnter * hi Normal ctermbg=none


" Tab pages
" Mapping key for moving between tabs
nnoremap <silent> <C-left> :tabprevious<CR>
nnoremap <silent> <C-right> :tabnext<CR>
inoremap <silent> <C-left> <Esc>:tabprevious<CR>
inoremap <silent> <C-right> <Esc>:tabnext<CR>

" Mapping key for moving current tab position
nnoremap <silent> <A-left> :tabm -1<CR>
nnoremap <silent> <A-right> :tabm +1<CR>
inoremap <silent> <A-left> <Esc>:tabm -1<CR>
inoremap <silent> <A-right> <Esc>:tabm +1<CR>

" Mapping key for tab focus toggling
let notabs = 0
nnoremap <silent> <C-o> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" Mapping key for opening tabs
noremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> <Esc>:tabe<CR>


" Airline styling
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#clock#format = '%H:%M'
let g:airline_theme = 'bubblegum'

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
let g:NERDTreeWinPos = "right"
nmap <silent> <C-b> :NERDTreeToggle<CR>
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
nmap <silent> <C-l> :Limelight!!<CR>


" Goyo zen mode
" Mapping keys for Goyo toggling
nmap <silent> <C-k> :Goyo<CR>

" Limelight integration
function! s:goyo_enter()
    set number
    set rnu
    hi Normal ctermbg=none

    Limelight

    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    hi Normal ctermbg=none
    
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
    \ 'coc-highlight',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-flutter',
    \ 'coc-eslint',
    \ 'coc-tsserver',
    \ 'coc-yaml',
    \ 'coc-clangd',
    \ 'coc-python',
    \ 'coc-java',
    \ 'coc-flutter',
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








