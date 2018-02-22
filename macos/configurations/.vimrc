set nocompatible
set tabstop=4
set shiftwidth=4
set mouse=a
set smartindent
set autoindent
set ignorecase

syntax on

au BufNewFile * startinsert

set hidden
set bh=wipe
set bs=indent,eol,start

vnorem n y/<c-r>"<cr>
