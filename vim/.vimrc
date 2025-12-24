" plugins
call plug#begin()

Plug 'menisadi/kanagawa.vim'
Plug 'tribela/vim-transparent'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'igemnace/vim-makery'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'

call plug#end()

" clipboard
if has('clipboard')
  set clipboard^=unnamed,unnamedplus
endif

" wayland clipboard mappings
xnoremap <silent> <leader>y :w !wl-copy<CR><CR>
nnoremap <silent> <leader>p :r !wl-paste<CR>

" netrw
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_winsize = -30

nnoremap <Leader>n :Lexplore<CR>

augroup netrw
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end

" text, tab and indent
set expandtab
set shiftwidth=2

set lbr
set tw=500

set autoindent
set smartindent
set wrap

" extras
set lazyredraw
set magic
set encoding=utf8
set ffs=unix,dos,mac

" tags
set tags=tags

" last edit position on file open
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" colorscheme
set termguicolors
colorscheme kanagawa

" statusline
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number

" set cursorline
set cursorline
set cursorlineopt=number

" numbers
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" disable backup
set nobackup
set nowb
set noswapfile

" use ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat^=%f:%l:%c:%m
endif

" KEYS

" quickfix list
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cf :cfirst<CR>
nnoremap <leader>cl :clast<CR>

" fzf
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fg :Ag<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fb :BTags<CR>

" buffer closing
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>

" tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" misc
" don't close window when deleting a buffer.
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

" fzf config

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_layout = { 'down': '40%' }
let g:fzf_vim = {}
let g:fzf_vim.preview_window = []
let g:fzf_vim.tags_command = 'ctags -R'

