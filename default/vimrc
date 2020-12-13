" This file contains no control codes and no `top bit set' characters above the
" normal Ascii range, and all lines contain a maximum of 79 characters.  With a
" bit of luck, this should make it resilient to being uploaded, downloaded,
" e-mailed, posted, encoded, decoded, transmitted by morse code, or whatever.

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
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tagbar#enabled = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set confirm                 " if unsaved changes, ask if you want to save
set bs=2                    " allow backspacing over everything in insert mode
set noautoindent            " set autoindenting off as it seems to make pasting
                            " not work
set report=1                " show a report when N lines were changed.
                            " report=0 thus means "show all changes"!
set noshowmatch             " disables backet matching
set ruler                   " always show current positions along the bottom
set nobackup                " no backups, please
set fileformat=unix         " automatically detected values for fileformat in
                            " this order
set autowrite               " write the old file out when switching from one
                            " file to another
set nostartofline           " don't jump to first character when paging
set ttyfast                 " improves redrawing
set lazyredraw              " don't update while in macro
set errorformat=%t%*[^0123456789]%n:\ \"%f\"\\,\ line\ %l\ #\ %m

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=999   " center line when paging
set nomodeline      " do not process modeline commands in files
set visualbell      " terminal's visual bell - turned off to make Vim quiet!
set t_vb=
set noerrorbells    " damn that beep!  ;-)
set history=150     " have lots of command-line (etc) history
set shortmess+=r    " use "[RO]" for "[readonly]" to save space in message line
set showmode        " display the current mode in the status line
set showcmd         " display the partially-typed command in the status line
set number          " show line numbers
set laststatus=2    " always show status line as second last line in edit window

syntax on           " turn on syntax highlighting on automatically

:colorscheme inkpot
":hi CursorLine term=bold cterm=bold guibg=Grey40

if version >= 700
  set cursorline   " highlight current line
  " :hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
  ":hi CursorLine   cterm=NONE ctermbg=lightblue ctermfg=grey guibg=lightblue guifg=white
  ":hi CursorColumn cterm=NONE ctermbg=lightblue ctermfg=white guibg=lightblue guifg=white
  :hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white
  :nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
  " Remove trailing whitespace on <leader>S
  nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>
endif

" Tell vim to remember certain things when we exit
"  "       Maximum number of lines saved for each register
"  %       When included, save and restore the buffer lis
"  '       Maximum number of previously edited files for which the marks are remembered
"  /       Maximum number of items in the search pattern history to be saved
"  :       Maximum number of items in the command-line history
"  <       Maximum number of lines saved for each register.
"  @       Maximum number of items in the input-line history
"  h       Disable the effect of 'hlsearch' when loading the viminfo
"  n       Name of the viminfo file.  The name must immediately follow the 'n'.
"  r       Removable media.  The argument is a string
"  s       Maximum size of an item in Kbyte
set viminfo=!,'100,\"100,:20,<50,s10,h

if !has('nvim')
  set viminfo+=n~/.viminfo
else
  " Do nothing here to use the neovim default
  " or do something like:
  set viminfo+=n~/.config/nvim/.shada
endif

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text Formatting -- General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4       " number of space <tab> counts for
set softtabstop=4   " how many columns to use when you hit Tab in insert mode
set shiftwidth=4    " shift width size
set shiftround      " indent/outdent to nearest tabstops
set expandtab       " fill tabs with spaces

" Insert two spaces after a period with every joining of lines.
" I like this as it makes reading texts easier (for me, at least).
set joinspaces

" normally don't automatically format `text' as it is typed, i.e. only do this
" with comments, at 79 characters:
set formatoptions-=t  " toggle text wrapping off
set textwidth=0       " controls the wrap width to use

" Lemme see those ugly tabs and trailing spaces
" set list   listchars=tab:»·,trail:·
" set listchars=tab:▸\ ,eol:¬,nbsp:_,trail:▋
set list listchars=tab:>-
" toggle displaying newline charaters and tabs [list]
nmap <leader>a :set list!<CR>

"toggle line numbering [number]
map <leader>n :set number!<CR>

" Get rid of trailing whitespace
nnoremap <leader>rtw :%s/\s\+$//e<CR>
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" * Text Formatting -- Specific File Formats
if version >= 600
    " enable filetype detection:
    filetype on

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
endif

" We still need tabs in Makefiles
:autocmd BufNewfile,BufRead *akefile* set noexpandtab nosmarttab
:autocmd BufNewfile,BufRead *.mak set noexpandtab nosmarttab

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab
autocmd FileType java setlocal commentstring=//\ %s

" C/Obj-C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,objc setlocal commentstring=//\ %s

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" JSON
" ----
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

let c_no_curly_error=1

if has( "gui_running" )
  " Make external commands work through a pipe instead of a pseudo-tty
  set noguipty

  "colorscheme xoria256

  " set the X11 font to use
  "set guifont=-misc-fixed-medium-r-normal--20-140-100-100-c-100-iso8859-1
  "set guifont=8x13
  "set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
  "set guifont=-mswin-isi_vga-normal-r-normal--0-0-75-75-m-0-symbol-fontspecific
  "set guifont=-*-lucidatypewriter-medium-r-*-*-*-120-*-*-*-*-iso8859-1
  "set guifont=-adobe-courier-medium-r-normal--12-*
  "set guifont=-b&h-lucidatypewriter-medium-r-normal-sans-12-120-75-75-m-70-iso8859-1
  "set guifont=-b&h-lucidatypewriter-medium-r-normal-sans-11-80-100-100-m-70-iso8859-1
  "set guifont=Monospace\ 9
  "set guifont=LucidaTypewriter\ 9

  set background=dark

  let c_comment_strings=1   " I like highlighting strings inside C comments
  if &t_Co > 2
    set hlsearch            " Switch on search pattern highlighting if have colours
  endif

  set mousehide             " Hide the mouse pointer while typing

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  :menu &MyVim.Current\ File.Convert\ Format.To\ Dos :set fileformat=dos<cr> :w<cr>
  :menu &MyVim.Current\ File.Convert\ Format.To\ Unix :set fileformat=unix<cr> :w<cr>
  :menu &MyVim.Current\ File.Remove\ Trailing\ Spaces\ and\ Tabs :%s/[  ]*$//g<cr>
  :menu &MyVim.Current\ File.Remove\ Ctrl-M :%s/^M//g<cr>
  :menu &MyVim.Current\ File.Remove\ All\ Tabs :retab<cr>
  :amenu &MyVim.-SEP1- <nul>
  :amenu &MyVim.&Global\ Settings.Toggle\ Display\ Unprintables<Tab>:set\ list! :set list!<CR>
endif

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
set smartcase    " ignore ignorecase when pattern contains uppercase
set gdefault     " assume the /g flag on :s substitutions to replace all matches in a line:
set incsearch    " find the next match as we type the search

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keystrokes -- Moving Around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
if version >= 600
    set whichwrap=h,l,~,[,]
else
    set whichwrap=h,l,[,]
endif

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd BufRead *       set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.h,*.cpp set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
augroup END

" ===================================================================
" Customizing the command line
" ===================================================================
" Valid names for keys are:  <Up> <Down> <Left> <Right> <Home> <End>
" <S-Left> <S-Right> <S-Up> <PageUp> <S-Down> <PageDown>  <LeftMouse>

" Many shells allow editing in "Emacs Style".
" Although I love Vi, I am quite used to this kind of editing now.
" So here it is - command line editing commands in emacs style:
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <ESC>b <S-Left>
cnoremap <ESC>f <S-Right>
cnoremap <ESC><C-H> <C-W>

" ===================================================================
" Useful stuff.  At least these are nice examples.  :-)
" ===================================================================
" Keyboard mapping for cursor keys
" [works for XTerminals - 970818]
map <ESC>[A <Up>
map <ESC>[B <Down>
map <ESC>[C <Right>
map <ESC>[D <Left>
imap <ESC>[A <Up>
imap <ESC>[B <Down>
imap <ESC>[C <Right>
imap <ESC>[D <Left>

" space / shift-space scroll in normal mode
noremap <S-space> <C-b>
noremap <space> <C-f>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto bracing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keystrokes -- Insert Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
if version >= 600
    set backspace=eol,start,indent
endif

"
" Mapping <SPACE> to next diff, and if using gvimdiff,
" <S-SPACE> to previous diff.
"
" The "z." centers the change in the middle of your screen. It
" makes it so much nicer running through diffs to have the next diff
" in the same place so your eyes do not have to search for where the
" cursor is after each next diff.

if &diff
    noremap <space> ]cz.
    noremap <S-space> [cz.
endif

" ===================================================================
" Mapping of special keys - arrow keys and function keys.
" ===================================================================
" Emacs style editing in insert mode
imap <C-A>  <ESC>0i
imap <C-B>  <ESC>hi
imap <C-D>  <ESC>xi
imap <C-E>  <ESC>A
imap <C-F>  <ESC>lli
imap <C-N>  <ESC>jli
imap <C-P>  <ESC>kli
imap <ESC>b <ESC>bi
imap <ESC>f <ESC>lWi

" Make up down left right keys work in KornShell (ksh) Command line
" http://stackoverflow.com/questions/7831021/make-up-down-left-right-keys-work-in-kornshell-ksh-command-line
set cpo-=<
set exrc
set fileformats=unix,dos,mac
nmap k <Up>
nmap j <Down>
nmap h <Left>
nmap l <Right>

" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" Undo in insert mode.
imap <c-z> <c-o>u

if &term =~ 'xterm'
  if $COLORTERM == 'gnome-terminal'
    execute 'set t_kb=' . nr2char(8)
    fixdel
    set t_RV=
  elseif $COLORTERM == ''
    execute 'set t_kb=' . nr2char(8)
    fixdel
  endif
endif

" ===================================================================
" This version of SmartHome does not work in insert mode.  It was
" replaced with the plugin homeLikeVC++.vim
" ===================================================================
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home>
imap <End> <C-o><End>

" ===================================================================
" Turning off auto indent when pasting text into vim. This will prevent
" un-wanted newlines and brace matching, etc. etc.
" ===================================================================
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Here's a little trick that uses terminal's bracketed paste mode to
" automatically set/unset Vim's paste mode when you paste.
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" ===================================================================
" Comment/Uncomment a region
"
" ,c comments out a region
" ,u uncomments a region
" ===================================================================
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

"-----------------------------------------------------------------
" Comment macros
"  https://github.com/japgolly/.golly-rc/blob/master/assets/.vimrc
"
" code seperation comments
au filetype ruby,sh,yaml                  nmap <silent> ,C- :set paste<CR>O<Esc>:set nopaste<CR>O#----------------------------------------------------------------------------------------------------------------------------<Esc>0120lD0jjw
au filetype scala,dot,javascript,cpp,c,css,scss nmap <silent> ,C- :set paste<CR>O<Esc>:set nopaste<CR>O//---------------------------------------------------------------------------------------------------------------------------<Esc>0120lD0jjw
nmap <silent> ,c- j,C-0kkw
" method doco
au filetype ruby nmap <silent> ,cD :set nopaste<CR>O#<CR><CR> @param <CR>@return <Esc>kkkA<SPACE>
au filetype ruby nmap <silent> ,Cd ,cD
au filetype ruby nmap <silent> ,cd j,cD
" @!visibility private declarations
au filetype ruby nmap <silent> ,cVP :set nopaste<CR>O# @!visibility private<Esc>0jw
au filetype ruby nmap <silent> ,Cvp ,cVP
au filetype ruby nmap <silent> ,cVp ,cVP
au filetype ruby nmap <silent> ,cvP ,cVP
au filetype ruby nmap <silent> ,cvp j,cVP
" comment line joining
au filetype ruby nmap <silent> ,cj Jd/#<CR>xd/[^ ]<CR>i <Esc>l
au filetype ruby nmap <silent> ,cJ k,cj

" CTRL-/ adds comments
au filetype ruby,sh,yaml                  map <silent>  :s/^\(\s*.\)/#\1/<CR>:set nohlsearch<CR>
au filetype vim                           map <silent>  :s/^\(\s*\)\("\s*\)\?/\1" /<CR>:set nohlsearch<CR>
au filetype plantuml                      map <silent>  :s/^\(\s*\)\('\s*\)\?/\1' /<CR>:set nohlsearch<CR>
au filetype scala,dot,javascript,cpp,c,css,scss map <silent>  :s/^\(\s*\)\(\/\/\s*\)\?/\1\/\/ /<CR>:set nohlsearch<CR>
au filetype haskell,sql                   map <silent>  :s/^\(\s*\)\(--\s*\)\?/\1-- /<CR>:set nohlsearch<CR>
au filetype haml                          map <silent>  :s/^\(\s*\)\(-#\s*\)\?/\1-# /<CR>:set nohlsearch<CR>
au filetype xml                           map <silent>  :s/^\(\s*\)/\1<!--/<CR>:s/$/-->/<CR>:set nohlsearch<CR>
imap <silent>  <Esc>w

" CTRL-\ removes comments
"au filetype ruby,sh,yaml map  <silent>  :s/^\(\s\s*#\s*\\|\s*#\s\s*\\|\(\s*\)#\(.*\)\)$/\2\3/<CR>:set nohlsearch<CR>
au filetype ruby,sh,yaml                  map <silent>  :s/^\(\s*\)#\s*/\1/<CR>:set nohlsearch<CR>
au filetype vim                           map <silent>  :s/^\(\s*\)"\s*/\1/<CR>:set nohlsearch<CR>
au filetype plantuml                      map <silent>  :s/^\(\s*\)'\s*/\1/<CR>:set nohlsearch<CR>
au filetype scala,dot,javascript,cpp,c,css,scss map <silent>  :s/^\(\s*\)\/\/\s*/\1/<CR>:set nohlsearch<CR>
au filetype haskell,sql                   map <silent>  :s/^\(\s*\)--\s*/\1/<CR>:set nohlsearch<CR>
au filetype haml                          map <silent>  :s/^\(\s*\)-#\s*/\1/<CR>:set nohlsearch<CR>
au filetype xml                           map <silent>  :s/^\(\s*\)<!--\s*/\1/<CR>:s/-->\(\s*\)$/\1/<CR>:set nohlsearch<CR>
imap <silent>  <C-O>

" ===================================================================
" Show file format on status line
" ===================================================================
"let g:main_ff = substitute(&ffs, ',.*', '', '')
"set statusline=[%02n]\ %<%f\ %h%m%r%{&ff==g:main_ff?'':'['.&ff.']'}%=%-14.(%4l,%02c%2V%)\ %P

set statusline+=[%02n] "buffer number
set statusline+=%*

"set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*

"display a warning if file format isn't Unix
"set statusline+=%#warningmsg#
set statusline+=%#error#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
"set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
"set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

set statusline+=\ 0x%04B   "character under cursor
set statusline+=%*

set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction
