"Required for Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'rust-lang/rust.vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'Valloric/YouCompleteMe'
" All of your Plugins must be added before the following line
call vundle#end()            " required

" Enable syntax highlighting
syntax on
" Use vimrc files in ftplugin
filetype plugin on

inoremap jk <Esc>



" Start pathogen for plugins
execute pathogen#infect()

"inoremap <leader>b <esc>:b #<return>
"noremap <leader>b :b #<return>

"Use 4 spaces instead of tab
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4 expandtab

"Delete and paste without yanking
"nnoremap d "_d
"vnoremap d "_d
"
""Delete and paste with yanking
"nnoremap <leader>d d
"vnoremap <leader>d d
"
"nnoremap <leader>dd dd
"vnoremap <leader>dd dd
"
"vnoremap <leader>d d
vnoremap p "_dP

nnoremap <leader>c "_d
vnoremap <leader>c "_d

runtime macros/matchit.vim

" Rust stuff!
"nnoremap <S-F8> :!cargo test
"nnoremap <S-F9> :!cargo run 
"nnoremap <S-F10> :!cargo test && cargo run
"
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"
"" let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, 'python':1 }
let g:ycm_filetype_whitelist = { }
"
inoremap <leader>f gqip
nnoremap <leader>f gqip

"Very smart indent
set smartindent
set cinkeys-=0#
set indentkeys-=0#
"autocmd FileType c,cpp setlocal cindent smartindent
autocmd FileType c,cpp setlocal cindent
autocmd BufNewFile,BufRead *.handlebars setlocal noexpandtab filetype=html
autocmd FileType html,php setlocal noexpandtab
autocmd FileType make setlocal noexpandtab 
autocmd BufNewFile,BufRead *.mdd setlocal noexpandtab fo=aw2tq

"disable cursor blinking
:set guicursor+=a:blinkon0
"
"" Can't paste without it
set clipboard=unnamedplus
"
"" Ignore case during search
set ignorecase
"
set history=1000
"
"" Highlight current line
set cursorline

" source: Drew Neil - Practical Vim
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"
"" Move to end and start of line with L and H
noremap H ^
noremap L $
"
"" Easier to reach on AZERTY keyboard
"noremap � %
"
"" Center the screen after scrolling with ctrl-d and ctrl-u
noremap <c-d> <c-d>zz
noremap <c-u> <c-u>zz
"
"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
"
"" Disable all beeping sounds
set vb t_vb=

set hlsearch

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

"noremap <Leader>n nzz
"noremap <Leader>N Nzz
noremap n nzz
noremap N Nzz


cnoremap <C-v> <C-r>"

" Better leader key
let mapleader=","

" Allow to backspace any text in insert mode
set backspace=indent,eol,start

noremap <space> :w!<cr>
" Good colorscheme and font
colorscheme solarized 

if has('gui_running')
    set background=light
    set lines=999 columns=120
    nnoremap $ :promptfind<CR>
else
    set background=dark
endif

set guifont=DejaVu\ Sans\ Mono\ 12

" Enable line number
set number

" Highlight column 80
set colorcolumn=80

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Fast window/splits movement 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Fast tabs movement
nnoremap gt :tabnext<CR>
nnoremap gT :tabprevious<CR>
nnoremap GT :tabprevious<CR>

" Saving with ctrl-s
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>i

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ \ CWD:\ %r%{getcwd()}%h\ \ %=%l:%c

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

inoremap � <Esc>
