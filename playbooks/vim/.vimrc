:color desert

call plug#begin()
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'prabirshrestha/vim-lsp'
call plug#end()

source ~/.vim/lsp.vim

augroup QuickFix
  autocmd!
  autocmd FileType qf nnoremap <buffer> j j<CR>:execute 'match Search /\%'.line('.').'l.*/' \| wincmd p<CR>
  autocmd FileType qf nnoremap <buffer> k k<CR>:execute 'match Search /\%'.line('.').'l.*/' \| wincmd p<CR>
  autocmd FileType qf nnoremap <buffer> <CR> <CR><Cmd>match none<CR>
augroup END