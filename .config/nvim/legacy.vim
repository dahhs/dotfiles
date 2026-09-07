syntax on
set number 
set encoding=utf-8
"set wrap
set nowrap
set mouse=a
set shortmess+=c
set signcolumn=yes

set hlsearch
set incsearch

set nobackup
set nowritebackup
set noswapfile

set tabstop=4      " 一個 Tab 顯示寬度為 N 格
set shiftwidth=4   " << 或 >> 每次縮排 N 格
set expandtab      " 將 Tab 鍵自動轉成空格

set t_Co=256
set notermguicolors " Can switch to notermguicolors

set updatetime=100

" vim 執行時不需考慮和 vi 相容。預設為開啟，所以不設定
" set nocompatible

set autoread


" no folds, ever
set foldlevelstart=99

" C/C++ indent options: fix extra indentation on function continuation
set cino=(0,W4

" copy and paste out of vim
vnoremap <silent> ;y "+y<CR>

nnoremap <silent> ff yiw
nnoremap <silent> fi viwp

" Use ctrl + y as in VSCode
nnoremap r <Cmd>redo<CR>

noremap <silent> ;q :q<CR>
nnoremap <silent> ;w :update<CR>
nnoremap <silent> ;wq :update \| :q<CR>
nnoremap <silent> ;Q :q!<CR>

nnoremap // :noh<CR>

" Map insert mode CTRL-{hjkl} to arrows
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
" tab / Shift Tab。在Normal模式下，數字+Tab可以多行移動
nnoremap <S-Tab> <<
nnoremap <Tab> >> 
" Shift + tab for insert mode
inoremap <S-Tab> <C-d>
" Move single line Up or Down in Normal Mode
nnoremap <C-j> :move+<CR>==
nnoremap <C-k> :move-2<CR>==
" Move selected lines Up or Down in V-LINE (VISUAL) Mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" 右縮排並保持選中
vnoremap > >gv
" 左縮排並保持選中
vnoremap < <gv

" open same file in vertical/horizonal splits
nnoremap <silent> ;vmp :leftabove vsplit %<CR>
nnoremap <silent> ;xmp :leftabove split %<CR>

nnoremap ;s :s/
xnoremap ;s y:%s/<C-r>"//g<Left><Left>
" easy search/replace on current line with visual selection
xnoremap ;ls y:.s/<C-r>"//g<Left><Left>

" 實驗 ;s 與 ;ls mapping
"    Foo bar Foo
"    baz Foo qux
"    error error ok error

" Toggle auto-complete for LeetCoding
nnoremap ;af :lua require("cmp").setup.buffer({ completion = { autocomplete = false } })<CR>
nnoremap ;at :lua require("cmp").setup.buffer({ completion = { autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged } } })<CR>

" language-specific formatters. Select text and Press 'gq' to format
au FileType cpp set formatprg=clang-format | set equalprg=clang-format

" Only apply in when Makefile exists. 
au FileType c nnoremap <silent> ;k :VimuxRunCommand "make"<CR>
au FileType cpp nnoremap <silent> ;k :VimuxRunCommand "make"<CR>
" au FileType c nnoremap <silent> ;k :VimuxRunCommand("make ")<CR>

" 使用vimux一鍵執行c、cpp、python。注意"gcc " 一定要有空格
au Filetype c nnoremap <silent> ;r :VimuxRunCommand("clang " . bufname("%") . " && ./a.out")<CR>	" OJ 練完後取消註解
au Filetype cpp nnoremap <silent> ;r :VimuxRunCommand("clang++ " . bufname("%") . " && ./a.out")<CR>
au Filetype python nnoremap <silent> ;r :VimuxRunCommand("python3 " . bufname("%"))<CR>

" 為了暫時練 OJ 方便先設定為這樣，原設定在 107 行
"au Filetype c nnoremap <silent> ;r :VimuxRunCommand("clang " . bufname("%") . " && ./a.out < input.txt")<CR>

" ;m = make <filename> && ./<filename> 
" %  意思是檔名 
" :r 修飾檔名。假設是main.c則會變成main
" -s, --silent, --quiet       Don't echo commands.
" In command mode we should use :echo expand("%:t:r")
au FileType c nnoremap <silent> ;m :VimuxRunCommand("make " . expand("%:r") . " && ./" . expand("%:r"))<CR>
au FileType c nnoremap <silent> ;m :VimuxRunCommand("make -s " . expand("%:r") . " && ./" . expand("%:r"))<CR>


" 等號對齊: glip=
" 行首對齊: glip + Enter
let g:lion_squeeze_spaces = 1


" colorcolumn 80 when opening C/C++ or py
autocmd BufRead,BufNewFile *.c setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.h setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.cpp setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.hpp setlocal colorcolumn=80
autocmd BufRead,BufNewFile *.py setlocal colorcolumn=80

" 要手動判定.h的文件類型是c
autocmd BufRead,BufNewFile *.h set filetype=c
autocmd BufRead,BufNewFile *.jsonl set filetype=json

" 將 .S file 的註解改為 #：
autocmd FileType asm let b:commentary_format = '# %s'

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case-insensitive feature
let g:EasyMotion_startofline = 1

nmap .s <Plug>(easymotion-overwin-f)
nmap .d <Plug>(easymotion-overwin-f2)
nmap .g <Plug>(easymotion-overwin-w)
nmap .t <Plug>(easymotion-tl)    
nmap .f <Plug>(easymotion-fl)  
" Line motion above current line
nmap .j <Plug>(easymotion-j)    
nmap .k <Plug>(easymotion-k)    
nmap ./ <Plug>(easymotion-overwin-line)
nmap .a <Plug>(easymotion-jumptoanywhere)

