"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set confirm                 " if unsaved changes, ask if you want to save
"set nocompatible            " Use Vim defaults (much better!)
set bs=2                    " allow backspacing over everything in insert mode
set noautoindent            " set autoindenting off as it seems to make pasting not work
set report=1                " show a report when N lines were changed.
                            " report=0 thus means "show all changes"!
set noshowmatch             " disables backet matching
set noruler
set nobackup                " no backups, please
set fileformat=unix         " automatically detected values for file format in this order
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

"syntax on       " turn on syntax highlighting on automatically

set cursorline   " highlight current line
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

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
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
"set viminfo=%,'50,\"100,:100,n~/.viminfo

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mouse
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 set mouse=a
 map <ScrollWheelUp> <C-Y>
 map <ScrollWheelDown> <C-E>

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

" * Text Formatting -- Specific File Formats
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
set matchpairs+=<:>  " have % bounce between angled brackets, as well as t'other kinds:

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
set backspace=eol,start,indent

" ===================================================================
" Status line
" ===================================================================
set statusline=         "clear status line when .vimrc is loaded

set statusline+=[%02n]  "buffer number
set statusline+=%t      "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

" display current git branch
set statusline+=%{StatuslineGit()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%#warningmsg#
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=\ lin:%l/%L  "cursor line/total lines
set statusline+=\ col:%c%V   "cursor column
set statusline+=\ pos:%o     "character position in the file
set statusline+=\ ascii:%b   "ascii value of current character"
set statusline+=\ hex:%B     "hex value of current character
set statusline+=\ %p%%       "percent through the file

set laststatus=2    " Always show status line as second last line in edit window

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
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

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

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
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
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
