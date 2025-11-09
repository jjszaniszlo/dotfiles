" plugins
call plug#begin()

Plug 'menisadi/kanagawa.vim'
Plug 'tribela/vim-transparent'

Plug 'tpope/vim-sensible'
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" clipboard
set clipboard^=unnamed,unnamedplus

" netrw
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_winsize = 30

nnoremap <Leader>n :Lexplore<CR>

augroup netrw
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end

" rooter
let g:rooter_targets = ['/', '/home/*']
let g:rooter_patterns = ['.editorconfig']

" text, tab and indent
set expandtab

set shiftwidth=4
set tabstop=4

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
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" KEYS

" buffer closing
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>

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

" tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" search for current selection in visual mode
vnoremap <silent> * :call VisualSelection('', '')<CR>
vnoremap <silent> # :call VisualSelection('', '')<CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
