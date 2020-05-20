"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vundle - vim bundle manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required. Use Vim defaults (much better!)
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'                " git plugin
Plugin 'vim-airline/vim-airline'           " make statusline awesome
Plugin 'vim-airline/vim-airline-themes'    " themes for statusline 

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set confirm                 " if unsaved changes, ask if you want to save
set nocompatible            " Use Vim defaults (much better!). Required for Vundle
set bs=2                    " allow backspacing over everything in insert mode
set noautoindent            " set autoindenting off as it seems to make pasting not work
set nocindent               " I indent my code myself.
set smartindent             " Or I let the smartindent take care of it.
set breakindent             " indent line-breaks at the same level as code.
set report=1                " show a report when N lines were changed.
                            " report=0 thus means "show all changes"!
set showmatch               " show matching brackets
set number                  " show the line number on the left side
set ruler
set nobackup                " no backups, please
set fileformats=unix,dos,mac  " Use Unix as the standard file type
set autowrite               " write the old file out when switching from one
                            " file to another
set nostartofline           " don't jump to first character when paging
set ttyfast                 " improves redrawing
set lazyredraw              " don't update while in macro
set laststatus=2            " show status line always
set mouse-=a                " enable mouse in all modes
set backspace=eol,start,indent " Configure backspace so it acts as it should act
set errorformat=%t%*[^0123456789]%n:\ \"%f\"\\,\ line\ %l\ #\ %m

" Vim wide ignore files
set wildmenu                " enhanced command line completion
set wildmode=list:longest,full  " Complete files using a menu AND list
set wildignorecase
set wildignore+=.git,.hg,.svn
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*.gem
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,.lock,.DS_Store,._*
set wildignore=*.swp,*.bak
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,.DS_Store,*/.git,*.bak
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/vendor,*/target,*/test-output

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline_section_warning = ''
"let g:airline_section_error = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 0

set cursorline
:hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white
set visualbell      " terminal's visual bell - turned off to make Vim quiet!
set t_vb=
set noerrorbells    " damn that beep!  ;-)
set history=150     " have lots of command-line (etc) history
set shortmess+=r    " use "[RO]" for "[readonly]" to save space in message line

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Enable syntax highlighting
syntax enable

" Syntax highlighting in Markdown
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:polyglot_disabled = ['markdown']
let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'scala', 'xml', 'html', 'vim']

" Configure NVIM's viminfo file
" Tell vim to remember certain things when we exit
"  "       Maximum number of lines saved for each register
"  %       When included, save and restore the buffer list
"  '       Maximum number of previously edited files for which the marks are remembered
"  /       Maximum number of items in the search pattern history to be saved
"  :       Maximum number of items in the command-line history
"  <       Maximum number of lines saved for each register.
"  @       Maximum number of items in the input-line history
"  h       Disable the effect of 'hlsearch' when loading the viminfo
"  n       Name of the viminfo file.  The name must immediately follow the 'n'.
"  r       Removable media.  The argument is a string
"  s       Maximum size of an item in Kbyte
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.config/nvim/.shada

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text Formatting -- General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4           " number of space <tab> counts for
set softtabstop=4       " how many columns to use when you hit Tab in insert mode
set shiftwidth=4        " shift width size
set shiftround          " indent/outdent to nearest tabstops
set expandtab           " fill tabs with spaces
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set foldenable


" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" normally don't automatically format `text' as it is typed, i.e. only do this
" with comments, at 79 characters:
set formatoptions-=t  " toggle text wrapping off
set textwidth=0       " controls the wrap width to use

set pastetoggle=<F2>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
filetype plugin indent off

" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78

" for C-like programming, have automatic indentation:
autocmd filetype c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment
" automatically insert the comment leader characters:
autocmd filetype c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd filetype perl set smartindent

" for CSS, also have things in braces indented:
autocmd filetype css set smartindent

" for HTML, generally format text, but if a long line has been created
" leave it alone when editing:
autocmd filetype html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation,
" to make files a few bytes smaller:
autocmd filetype html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters
" are needed, and have indentation at 8 chars to be sure that all indents
" are tabs (despite the mappings later):
autocmd filetype make set noexpandtab shiftwidth=8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix my typos; I always do this
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap :W :w
nmap :Wq :wq
nmap :Q :q

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  Search & Replace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase   " ignore case in search patterns
set smartcase    " ... but not if it begins with uppercase
set gdefault     " assume the /g flag on :s substitutions to replace all matches in a line:
set incsearch    " find the next match as we type the search
set hlsearch     " don't highlight search terms

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    noremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CRe

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keystrokes -- Moving Around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set matchpairs+=<:>  " have % bounce between angled brackets, as well as t'other kinds:

"Enter to go to EOF and backspace to go to start
nnoremap <CR> G
nnoremap <BS> gg
" Stop cursor from jumping over wrapped lines
nnoremap j gj
nnoremap k gk
" Make HOME and END behave like shell
inoremap <C-E> <End>
inoremap <C-A> <Home>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto bracing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {     {
inoremap {}     {}

" Set cursor as blinking in insert mode, and a square in normal mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Folding behaviour
set foldlevelstart=10
set foldnestmax=10           " maximun nesting of folds
set foldmethod=manual        " folds are created manually

" Move around easier in insert mode
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

" Strong H/L
nnoremap H 0
nnoremap L $

" Make yanking an entire line much easier
nnoremap yl 0y$

" Cut function
nnoremap yd 0y$dd

" Disable search highlight when <Leader>+<Space> is pressed
nnoremap <silent> <leader><space> :noh<cr>

