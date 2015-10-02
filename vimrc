set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/gmarik/Vundle.vim
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Languages
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'vim-scripts/jQuery'
Plugin 'kchmck/vim-coffee-script'
" Plugin 'jnwhiteh/vim-golang'
Plugin 'tpope/vim-markdown'
Plugin 'fatih/vim-go'

" Colors
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'jpo/vim-railscasts-theme'
" Plugin 'commonthread/vim-vibrantink'
Plugin 'tpope/vim-vividchalk'

" Tools
" Plugin 'wincent/Command-T'
Plugin 'mileszs/ack.vim'
" Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Make (V)im play nicely with (i)Term 2 and (t)mux
"Plugin 'sjl/vitality.vim'

" These three needed for turbux
"Plugin 'jgdavey/vim-turbux'
"Plugin 'tpope/vim-dispatch'
Plugin 'benmills/vimux'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ^^^^^^^^^
" End Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" set shell=/bin/sh


" Source this file after saving it
" autocmd bufwritepost .vimrc source $MYVIMRC
" autocmd bufwritepost .vimrc source ~/.vimrc.bundles

syntax on " Enable syntax highlighting
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
"colorscheme railscasts
colorscheme vividchalk
"colorscheme solarized

" Set a dark background after colorscheme is loaded
set background=dark

" Make https://github.com/airblade/vim-gitgutter work with colorscheme
highlight clear SignColumn

" F5 to delete all trailing whitespace.
" The variable _s is used to save and restore the last search pattern register (so next time the user presses n they will continue their last search), and :nohl is used to switch off search highlighting (so trailing spaces will not be highlighted while the user types). The e flag is used in the substitute command so no error is shown if trailing whitespace is not found. Unlike before, the substitution text must be specified in order to use the required flag.
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Show characters over 100 lines
if exists('+colorcolumn')
  set colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

" AutoFormat Golang files
" autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Syntax highlighting for all spec files
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_behaves_like it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" Use the system clipboard as its default register
set clipboard=unnamed

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

" Save with leader-w
nmap <leader>w :w<cr>
" Explore with leader -e
nmap <leader>e :Explore<cr>

" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" Switch between files with leader-leader
nnoremap <leader><leader> <c-^>

" Golang stuff
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
au FileType go nmap <Leader>r <Plug>(go-run)
autocmd FileType go set commentstring=//\ %s
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SMASH
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map smashing j and k to exit insert mode
" inoremap jk <esc>
" inoremap kj <esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RELATIVE NUMBER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber

" Toggle relative number with Ctrl-n
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Switch to absolute line numbers whenever Vim loses focus, since we don’t
"   really care about the relative line numbers unless we’re moving around
autocmd FocusLost * :set norelativenumber
autocmd FocusLost * :set number
autocmd FocusGained * :set relativenumber

" " Use absolute line numbers when we’re in insert mode
" "   and relative numbers when we’re in normal mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" " Highlight cursor line in normal mode
" set cursorline
" autocmd InsertEnter * set nocursorline
" autocmd InsertLeave * set cursorline


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
" set winwidth=0
set winwidth=100
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=1
set winminheight=1
set winheight=9999

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

" Golang mappings
map <Leader>g :call GoRunFile()<CR>

" Open vimux on the side
let g:VimuxOrientation = "h"

function! GoRunFile()
  let l:command = "go run " . @%
  call RunSpecs(l:command)
endfunction

function! RunAllSpecs()
  let l:command = "$TEST_COMMAND"
  call RunSpecs(l:command)
endfunction

function! RunCurrentSpecFile()
  if InSpecFile()
    let l:command = "$TEST_COMMAND " . @%
  elseif InSpecJSFile()
    let l:command = "$TEASPOON_COMMAND " . @%
  elseif InFeatureFile()
    let l:command = "$CUCUMBER_COMMAND " . @%
  endif
  call SetLastSpecCommand(l:command)
  call RunSpecs(l:command)
endfunction

function! RunNearestSpec()
  if InSpecFile()
    " Rspec < 3
    " let l:command = "$TEST_COMMAND " . " -l " . line(".") . " "  . @%
    let l:command = "$TEST_COMMAND " . @% . ":" . line(".")
  elseif InFeatureFile()
    let l:command = "$CUCUMBER_COMMAND " . @% . ":" . line(".")
  endif
  call SetLastSpecCommand(l:command)
  call RunSpecs(l:command)
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

function! InFeatureFile()
  return match(expand("%"), ".feature$") != -1
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

" command! -nargs=0 -bar Qargs execute 'args ' . s:QuickfixFilenames()

" " Contributed by "ib."
" " http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim#comment8286582_5686810
" command! -nargs=1 -complete=command -bang Qdo call s:Qdo(<q-bang>, <q-args>)

" function! s:Qdo(bang, command)
"   if exists('w:quickfix_title')
"     let in_quickfix_window = 1
"     cclose
"   else
"     let in_quickfix_window = 0
"   endif

"   arglocal
"   exe 'args '.s:QuickfixFilenames()
"   exe 'argdo'.a:bang.' '.a:command
"   argglobal

"   if in_quickfix_window
"     copen
"   endif
" endfunction

" function! s:QuickfixFilenames()
"   " Building a hash ensures we get each buffer only once
"   let buffer_numbers = {}
"   for quickfix_item in getqflist()
"     let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
"   endfor
"   return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
" endfunction

" Load custom configuration if we find it in the working directory
if filereadable(".vim.custom")
  so .vim.custom
endif

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" highlight SyntasticError guibg=#2f0000

" let g:syntastic_cursor_column = 1
" let g:syntastic_echo_current_error = 1
" let g:syntastic_enable_signs = 0

" install jshint and jscs globally, then install the syntastic vim plugin

  " Syntastic {
    " let g:syntastic_enable_signs=1
    " " let g:syntastic_quiet_messages = {'level': 'warnings'}
    " let g:syntastic_ruby_checkers=['mri']
    " " let g:syntastic_ruby_checkers=['rubocop']
    " let g:syntastic_go_checkers=['go']
    " let g:syntastic_javascript_checkers=['jshint', 'jscs']

    " set statusline=""
    " set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*
    " set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %p%%

    " let g:syntastic_always_populate_loc_list = 1
    " let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_open = 1 " if you're experiencing that Synstastic makes opening files slow, turn this off
    " let g:syntastic_check_on_wq = 0
  " }

au FileType javascript noremap <Leader>f :call FormatBuffer()<cr>

" This would ideally be filetype-specific, but it's just for JS right now
function! FormatBuffer()
  let l:winview = winsaveview()
  let l:folding = &foldenable
  let &foldenable = 0

  try
    %! js-beautify -f -
  catch
  endtry

  let &foldenable = l:folding
  call winrestview(l:winview)
endfunction
