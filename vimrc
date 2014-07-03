set nocompatible

set shell=/bin/sh

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

syntax on " Enable syntax highlighting
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins
set ic " Case insensitive search
set hls " Highlight search
set showmatch " Show matching brackets
set expandtab
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set title
set backupdir=/tmp/
set directory=/tmp/
set t_Co=256
"colorscheme vibrantink
colorscheme railscasts
"colorscheme vividchalk
"colorscheme solarized

" Set a dark background after colorscheme is loaded
set background=dark

" Show characters over 100 lines
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

" Syntax highlighting for all spec files
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_behaves_like it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" Format XML docs
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" List all matches without completing, then each full match
set wildmode=longest,list
" Make tab completion for files/buffers act like bash
set wildmenu

" Always save everything
set autowriteall
autocmd FocusLost * silent! wa

" Set leader to space
let mapleader=" "

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Switch between files with leader-leader
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SMASH
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map smashing j and k to exit insert mode
inoremap jk <esc>
inoremap kj <esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RELATIVE NUMBER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber

" Toggle relative number with Ctrl-n
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Switch to absolute line numbers whenever Vim loses focus, since we don’t
"   really care about the relative line numbers unless we’re moving around
autocmd FocusLost * :set number
autocmd FocusGained * :set relativenumber

" Use absolute line numbers when we’re in insert mode
"   and relative numbers when we’re in normal mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Highlight cursor line in normal mode
set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMAND-T MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open files with <leader>f
map <leader>t :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gt :CommandTFlush<cr>\|:CommandT %%<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Make the current window big, but leave others context
set winwidth=7
set winwidth=100
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=7
set winminheight=7
set winheight=999

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" rspec mappings
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>f :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

" Open vimux on the side
let g:VimuxOrientation = "h"

function! RunAllSpecs()
  let l:command = "bundle exec rspec"
  call RunSpecs(l:command)
endfunction

function! RunCurrentSpecFile()
  if InSpecFile()
    let l:command = "bundle exec rspec -fd " . @%
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  elseif InSpecJSFile()
    let l:command = "spring teaspoon " . @%
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunNearestSpec()
  if InSpecFile()
    " Rspec < 3
    " let l:command = "bundle exec rspec -fd " . " -l " . line(".") . " "  . @%
    let l:command = "bundle exec rspec -fd " . @% . ":" . line(".")
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunLastSpec()
  if exists("t:last_spec_command")
    call RunSpecs(t:last_spec_command)
  endif
endfunction

function! InSpecFile()
  return match(expand("%"), "_spec.rb$") != -1
endfunction

function! InSpecJSFile()
  return match(expand("%"), "_spec.js.coffee$") != -1
endfunction

function! SetLastSpecCommand(command)
  let t:last_spec_command = a:command
endfunction

function! RunSpecs(command)
  "execute ":w\|!clear && echo " . a:command . " && echo && " . a:command
  "call VimuxRunCommand(":w\|!clear && echo " . a:command . " && echo && " . a:command)
  call VimuxRunCommand(a:command)
endfunction

function! s:ChangeHashSyntax(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/:\([a-z0-9_]\+\)\s\+=>/\1:/g'
    call setpos('.', l:save_cursor)
endfunction

command! -range=% ChangeHashSyntax call <SID>ChangeHashSyntax(<line1>,<line2>)

command! -nargs=0 -bar Qargs execute 'args ' . s:QuickfixFilenames()

" Contributed by "ib."
" http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim#comment8286582_5686810
command! -nargs=1 -complete=command -bang Qdo call s:Qdo(<q-bang>, <q-args>)

function! s:Qdo(bang, command)
  if exists('w:quickfix_title')
    let in_quickfix_window = 1
    cclose
  else
    let in_quickfix_window = 0
  endif

  arglocal
  exe 'args '.s:QuickfixFilenames()
  exe 'argdo'.a:bang.' '.a:command
  argglobal

  if in_quickfix_window
    copen
  endif
endfunction

function! s:QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Load custom configuration if we find it in the working directory
if filereadable(".vim.custom")
  so .vim.custom
endif
