set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set autoindent
set smartindent
set number
" pathogen
"execute pathogen#infect()

colorscheme desert
if &diff
    hi diffadd ctermfg=white guifg=#000000
    hi diffdelete ctermfg=DarkRed guifg=#A43741
    hi DiffText ctermfg=white guifg=#000000
    " go to next difference
    nmap <C-Down> ]c
    " go to previous difference
    nmap <C-Up>   [c
endif
source $HOME/.vim/syntax/ifdef.vim

hi DiffChange ctermfg=0
set nocp
filetype plugin on
filetype plugin indent on
set ofu=syntaxcomplete#Complete

" using the tab character in insert mode for autocompletion
function! Smart_TabComplete()
    let line = getline('.')                         " current line

    "let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    let substr = strpart(line, -1, col('.'))         " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return "\<C-X>\<C-P>"                         " existing text matching
    elseif ( has_slash )
        return "\<C-X>\<C-F>"                         " file matching
    else
        return "\<C-X>\<C-O>"                         " plugin matching
    endif
endfunction
" a map to allow completion using the tab character
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" window management key mappings
nmap <C-J> <C-w>j
nmap <C-K> <C-w>k
nmap <C-H> <C-w>h
nmap <C-L> <C-w>l
nmap <C-N> <C-w>n

nmap <S-F> :cs find f 
" turning line numbering on and off with the function key F2
nmap <silent> <F2> :set invnumber<CR>
nmap <silent> <C-E> :Explore<CR>
" showing/hiding the function window on the left with the function key F3
noremap <silent> <F3>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F3>  <Esc><Esc>:Tlist<CR>
nmap <silent> ,l :set list!<CR>
" remove those awful control marks from log files
nmap  <F4> :%s/<C-V>\[0;3[1-4];40m<C-V>\\|<C-V>\[0m\\|<C-V>@//g<CR>
let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_qmake_settings = 'qmake;t:SystemVariables'

if has("cscope") && filereadable("/usr/bin/cscope")
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        let my_cs_files = split($CSCOPE_DB)
        for cs_file in my_cs_files
            if filereadable(cs_file)
                exec 'cs add '.cs_file
            endif
        endfor
    endif

    set csverb
endif

if match($TERM, "screen")!=-1
      set term=xterm
endif

if filereadable($HOME . "/.6wind-undef")
    source $HOME/.6wind-undef
endif

map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_remove_include_errors = 1
"let g:syntastic_cpp_check_header = 0
"let g:syntastic_cpp_no_include_search = 1
"if &term =~ "xterm"
" 256 colors
let &t_Co = 256
" restore screen after quitting
let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
let &t_te = "\<Esc>[?47l\<Esc>8"
if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
endif
"endif

if &diff
" diff mode
    set diffopt+=iwhite
endif
