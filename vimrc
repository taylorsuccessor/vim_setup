" taylorsuccessor
"================================================debbuger python
"let g:vimspector_base_dir='/Users/hashim.abdullah/.vim/bundle/vimspector'
"let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector
"
"nnoremap <Leader>dd :call vimspector#Launch()<CR>
"nnoremap <Leader>de :call vimspector#Reset()<CR>
"nnoremap <Leader>dc :call vimspector#Continue()<CR>
"
"nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
"nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
"
"nmap <Leader>dk <Plug>VimspectorRestart
"nmap <Leader>dh <Plug>VimspectorStepOut
"nmap <Leader>dl <Plug>VimspectorStepInto
"nmap <Leader>dj <Plug>VimspectorStepOver
"
"==========================================END======debbuger python

"=====================================================
"" General settings
"=====================================================
syntax enable                               " syntax highlight

set t_Co=256                                " set 256 colors
colorscheme wombat256mod                    " set color scheme

"set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code

set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}

set enc=utf-8	                            " utf-8 by default

set nobackup 	                            " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files

set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

set scrolloff=10                            " let 10 lines before/after cursor during scroll

set clipboard=unnamed                       " use system clipboard
"set mouse=a
"set relativenumber
"______________________stop arrows
"for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"  exec 'noremap' key '<Nop>'
"  exec 'inoremap' key '<Nop>'
"  exec 'cnoremap' key '<Nop>'
"endfor



set exrc                                    " enable usage of additional .vimrc files from working directory

"======================================================shell
"set secure                                  " prohibit .vimrc files to execute shell, create files, etc...
" execute command
nmap <leader><Enter> !!zsh<CR>

" Jump to next point and insert
nnoremap <leader>j /<++><CR>cgn


" Additional mappings for Esc (useful for MacBook with touch bar)
inoremap jj <Esc>
inoremap jk <Esc>


set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
"delete not copy
nnoremap d "1d
nnoremap dd "1dd

vnoremap d "1d
vnoremap dd "1dd

xnoremap p P

nnoremap c "1c
vnoremap c "1c
"============================files moving
"open files and moving
set nocompatible
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set ignorecase
set wildignore=\*.git/\*,\*/node_modules/\*,\*/target/\*,\*/tmp/\*,\*/public/\*,\*/vendor/\*,\*/.ide/\*,\*.png\*,\*.jpg\*
"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"" Search settings
"=====================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=42
" autocmd BufEnter *.py :call tagbar#autoopen(0)
nnoremap tag  :call tagbar#autoopen(0)<CR>

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
"autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments

nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeFind<CR>
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window left.

"=====================================================
"" SnipMate settings
"=====================================================
let g:snippets_dir='~/.vim/vim-snippets/snippets'
let g:snipMate = {'snippet_version' : 1}

"=====================================================
"" Riv.vim settings
"=====================================================
let g:riv_disable_folding=1

"=====================================================
"" Python settings
"=====================================================

" python executables for different plugins
let g:pymode_python='python3'
let g:syntastic_python_python_exec='python3'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%161v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=160
augroup END

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" syntastic
let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
"let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python3']

" YouCompleteMe
set completeopt-=preview

let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_show_diagnostics_ui = 0
nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""search"""""
map <leader>f <Plug>CtrlSFQuickfixPrompt  -I

map <C-f> <Plug>CtrlSFPrompt -I

vnoremap // "2y/\V<C-R>=escape(@2,'/\')<CR><CR>
vnoremap ff "2y:<C-u>Ag <C-r>=escape(@2,'/\')<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""END""""search"""""


"======================================================spell
"set spell spelllang=en_us
"setlocal spell spelllang=en_us

"===================================================END===spell



"==================================================split
set splitbelow splitright  "place of split
nnoremap  <C-h> <C-w>h
nnoremap  <C-j> <C-w>j
nnoremap  <C-l> <C-w>l
nnoremap  <C-k> <C-w>k



"=======================================================linter_formating
"autocmd BufWritePost *.py call flake8#Flake8()

"=======================================================php
":autocmd BufWritePost *.php !php-cs-fixer fix  <afile>
"
"nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
"nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>
"
"
"autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()



"=======================================================spead things
" to speed the micro
"set lazyredraw



" Enable python-mode plugin
let g:pymode = 1

" Keybindings for jumping to function definitions
nmap <leader>q <Plug>(python-mode-jump)
nmap <leader>t <Plug>(python-mode-jump-back)


































" Function to find the last parent directory containing composer.json
function! FindBaseDir()
    " Start from the directory of the current file
    let l:current_dir = expand('%:p:h')
    let l:found_dir = ''
    
    " Traverse up the directory tree
    while l:current_dir !=# '/'
        " Check if composer.json exists in the current directory
        if filereadable(l:current_dir . '/composer.json')
            " Update found_dir if composer.json is found
            let l:found_dir = l:current_dir
        endif
        
        " Move to the parent directory
        let l:current_dir = fnamemodify(l:current_dir, ':h')
    endwhile
    
    " Return the last found directory or an empty string if none was found
    return l:found_dir
endfunction


" Function to convert autoload_psr4.php array to value => key format and replace class name
function! ConvertPsr4AndReplaceClassName()
    " Define the path to the autoload_psr4.php file
        " Get the base directory containing composer.json
    let l:base_dir = FindBaseDir()
    echo l:base_dir

    " Check if base_dir was found
    if l:base_dir == ''
        echo "Base directory with composer.json not found!"
        return
    endif

    " Define the path to the autoload_psr4.php file
    let l:psr4_file = l:base_dir . '/vendor/composer/autoload_psr4.php'


    " Check if the file exists
    if !filereadable(l:psr4_file)
        echo "PSR-4 file not found!"
        return
    endif

    " Read the file content into a list of lines
    let l:lines = readfile(l:psr4_file)

    " Initialize an empty dictionary to store the converted values
    let l:converted = {}

    " Loop through the lines to process the array
    for l:line in l:lines
        " l:line = 'Illuminate\\' => array($vendorDir . '/laravel/framework/src/Illuminate'),
        let l:match = matchlist(l:line, '\v''([A-Za-z0-9_\\]+)''\s*\=\>\s*array\((.+)\)')

        " If match is successful
        if !empty(l:match)
            let l:key = l:match[1]
            let l:values = split(substitute(l:match[2], '\s\+', '', 'g'), ',')

            " Convert values to value => key format
            for l:value in l:values

                let l:key_without_slash = substitute(l:key, '\\\\', '\\', 'g')

                let l:value_without_vendor = substitute(l:value, '$vendorDir.''', 'vendor', 'g')
                let l:value_without_base = substitute(l:value_without_vendor, '\$baseDir\.''', l:base_dir, 'g')
                let l:value_without_cot = substitute(l:value_without_base, '''', '\/', 'g')

                let l:converted[l:value_without_cot] = l:key_without_slash
            endfor
        endif
    endfor

    " Get the class name under the cursor
    let l:word = expand('<cword>')

    " Initialize an empty variable to store the class name
    let l:classname = ''

    " Get all lines in the buffer
    let l:buffer_lines = getline(1, '$')

    " Loop through all lines to find the corresponding 'use' statement
    for l:line in l:buffer_lines
        if l:line =~ 'use\s\+\(.*' . l:word . '\)\(;\|\s\+\)'
            let l:classname = matchstr(l:line, 'use\s\+\(.*' . l:word . '\)\s*')
            let l:classname = substitute(l:classname, ' as .*', '', '')
            let l:classname = substitute(l:classname, 'use\s\+', '', '')
            let l:classname = substitute(l:classname, '\s*.*;', '', 'g')
            let l:classname = substitute(l:classname, '\s*', '', 'g')
            break
        endif
    endfor

    " If found, replace with the key from the dictionary and echo the full path
    if l:classname != ''
        let l:classname_without_backslashes = substitute(l:classname, '\\\\', '\\', 'g')

        " Find matching key

        let l:found_keys = []
        for l:key in keys(l:converted)

            if l:classname_without_backslashes =~ '^' . substitute(l:converted[l:key], '\\', '\\\\', 'g')  
                let l:found_keys += [l:key]
            endif
        endfor

        " If a matching key is found
        for l:found_key in l:found_keys
           
            let l:escaped_prefix = substitute(l:converted[l:found_key], '\\', '\\\\', 'g')
                let l:full_path = substitute(l:classname_without_backslashes, l:escaped_prefix, l:found_key, '')

                let l:full_path_forward_slash = substitute(l:full_path, '\\', '\/', 'g') . '.php'
                if filereadable(l:full_path_forward_slash)
                    execute 'split ' . l:full_path_forward_slash
                else
                    echo "File not found: " . l:full_path_forward_slash
                endif
        endfor


    else
        echo "Class not found in buffer!"
    endif
endfunction


" Map the function to a key (e.g., <leader>c for "convert and replace class name")
nnoremap <leader>c :call ConvertPsr4AndReplaceClassName()<CR>













function! ParseLine(line)

    let l:lineParts = split(a:line, ':')

    let l:filename = l:lineParts[0]
    let l:line_number = l:lineParts[1]
    let l:text = join(l:lineParts[2:], ':')

    let l:quickfix_entry = {'filename': l:filename, 'lnum': str2nr(l:line_number), 'text': l:text}

    return l:quickfix_entry
endfunction



function! SearchWithGrep()
    " Get the word under the cursor
    let l:word = expand('<cword>')

    " Define the search path using FindBaseDir() (replace with actual path if necessary)
    let l:search_path = FindBaseDir()

    " Get the file extension of the current buffer
    let l:extension = expand('%:e')

    " Construct the grep command
    let l:grep_command = 'grep -n -rHn -A 4 -B 4 ' . shellescape(l:word) . ' --exclude-dir=vendor --exclude-dir=.git --exclude-dir=node_modules --include=''*.' . l:extension . ''' '  . shellescape(l:search_path)
    echo l:grep_command

    " Run the grep command and process the output with awk
    "
    let l:grep_output = systemlist(l:grep_command)
    if v:shell_error
        echohl Error | echo "Grep command failed" | echohl None
        return
    endif

    " Convert the grep output to the quickfix format
    let l:quickfix_list = []

    let l:searchFounded = 0
    let l:quickfix_entry = {}
    let l:text = ''
    let l:oneSearch_quickfix_entry = []
    for l:line in l:grep_output
        if l:line =~ '\v\w+\.\w+-\d+-.*'

            let l:matches = matchlist(l:line,  '\v(\w+\.\w+)-(\d+)-(.*)')
            if len(l:matches) >= 4 && !empty(l:matches[3])
                let l:oneSearch_quickfix_entry += [{'filename': '', 'lnum': '', 'text': l:matches[3]}]
            endif

        elseif l:line =~ '\v\w+\.\w+:\d+:.*'
            
            let l:searchFounded = 1
            let l:quickfix_entry = ParseLine(l:line)
            let l:oneSearch_quickfix_entry += [{'filename': '', 'lnum': '', 'text': l:quickfix_entry['text']}]
            let l:quickfix_list += [l:quickfix_entry]

        elseif l:line == '--'
            

            let l:quickfix_list += l:oneSearch_quickfix_entry
            let  l:oneSearch_quickfix_entry = []
            let l:searchFounded = 0

        endif

        "break
    endfor


        if l:searchFounded == 1
            let l:quickfix_list += l:oneSearch_quickfix_entry
            let  l:oneSearch_quickfix_entry = []

        endif


    " Set the quickfix list
    call setqflist(l:quickfix_list, 'r')
    " tabnew
    " Open the quickfix window
    vsplit
     copen
endfunction

nnoremap <leader>s :call SearchWithGrep()<CR>



"_____________________________________________________________________________________html                                                                                                                                                 


autocmd BufRead,BufNewFile *.twig,*.blade.php,*.html,*.htm set filetype=html

autocmd FileType html syntax include @htmlSyntax syntax/html.vim


augroup extended_html_syntax
    autocmd!
    autocmd BufRead,BufNewFile *.twig,*.blade.php,*.html,*.htm setlocal syntax=html
    autocmd FileType html setlocal syntax=html
augroup END


function! HtmlColorSyntax()
    syntax match HtmlColorHex "#\x\x\x\x\x\x" containedin=ALL
    syntax match HtmlColorRgb "rgb(\s*\d\{1,3},\s*\d\{1,3},\s*\d\{1,3}\s*)" containedin=ALL

    highlight HtmlColorHex ctermfg=Red guifg=#FF0000
    highlight HtmlColorRgb ctermfg=Green guifg=#00FF00
endfunction

autocmd BufRead,BufNewFile *.twig,*.blade.php,*.html,*.htm call HtmlColorSyntax()


"__________________________________________________________________________________END___html                                                                                                                                                 





