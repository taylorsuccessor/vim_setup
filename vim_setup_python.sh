#!/bin/bash
set -e

# Set up directories
PYTHON_VENV_DIR="$HOME/.python_vim"
NVM_DIR="$HOME/.nvm"
NEOVIM_DIR="$HOME/neovim"

# 📦 Install build dependencies if needed manually (no sudo here)

# ⬇️ Clone and build Neovim locally
echo "⬇️ Cloning and building Neovim locally..."
git clone https://github.com/neovim/neovim.git $NEOVIM_DIR
cd $NEOVIM_DIR
git checkout stable
make CMAKE_BUILD_TYPE=Release
export MANPATH=$HOME/.local/share/man:$MANPATH
make install DESTDIR=$HOME/.local PREFIX=$HOME/.local MANPREFIX=$HOME/.local/share/man

cd ..

# 🟢 Install NVM and Node.js LTS (user-only)
echo "🟢 Installing NVM and Node.js LTS..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# 🐍 Create Python virtual environment
echo "🐍 Creating Python virtualenv at $PYTHON_VENV_DIR"
python3 -m venv "$PYTHON_VENV_DIR"
source "$PYTHON_VENV_DIR/bin/activate"

# ⬇️ Install Python tools
echo "⬇️ Installing Python packages..."
pip install --upgrade pip
pip install black isort flake8 debugpy pynvim poetry

# 🪝 Install vim-plug
echo "🪝 Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 📁 Create init.vim
mkdir -p ~/.config/nvim/colors
curl -o ~/.config/nvim/colors/wombat256mod.vim https://raw.githubusercontent.com/flazz/vim-colorschemes/master/colors/wombat256mod.vim

# 📝 Create init.vim
cat <<EOF > ~/.config/nvim/init.vim
"================== General Settings ==================

inoremap jj <Esc>
set nocompatible
syntax enable
set encoding=utf-8
set t_Co=256
colorscheme wombat256mod

set ruler
set cursorline
set showmatch
set hidden
set ttyfast
set updatetime=300
set mouse=i
set ignorecase
set smartcase

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set autoindent
set backspace=indent,eol,start
set clipboard=unnamed
set scrolloff=10
set splitbelow splitright
set laststatus=2

set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

if !isdirectory(expand('~/.vim/undodir/'))
    call mkdir(expand('~/.vim/undodir/'), 'p')
endif

if !isdirectory(expand('~/.vim/colors/'))
    call mkdir(expand('~/.vim/colors/'), 'p')
endif

if !isdirectory(expand('~/.vim/sessions/'))
    call mkdir(expand('~/.vim/sessions/'), 'p')
endif

let g:python3_host_prog = expand('$PYTHON_VENV_DIR/bin/python3')

call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'honza/vim-snippets'

call plug#end()

let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-snippets',
  \ 'coc-prettier'
  \ ]

nnoremap <leader>gd <Plug>(coc-definition)
nnoremap <leader>gr <Plug>(coc-references)

let g:ale_fix_on_save = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['black', 'isort']}

nnoremap <C-t> :NERDTreeFind<CR>
nnoremap <C-f> :Telescope find_files<CR>
nnoremap <C-s> :Telescope live_grep<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap jj <Esc>
inoremap jk <Esc>

let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']
let NERDTreeWinSize=40
nnoremap <leader>n :NERDTreeFocus<CR>
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
autocmd FileType netrw setl bufhidden=delete

nmap <F5> <Plug>VimspectorContinue
nmap <F8> <Plug>VimspectorStop
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut

let g:pymode = 1
let g:pymode_python='python3'
let g:pymode_virtualenv=1
let g:pymode_run=1
let g:pymode_run_bind='<F5>'
let g:pymode_syntax=1
let g:pymode_indent=1
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

vnoremap // "2y/\V<C-R>=escape(@2,'/\')<CR><CR>
vnoremap ff "2y:<C-u>Ag <C-r>=escape(@2,'/\')<CR><CR>

autocmd VimLeave * execute 'mksession! ~/.vim/sessions/session_00000auto_' . strftime('%Y-%m-%d_%H') . '_' . fnamemodify(expand('%'), ':t') . '.vim'

function! SourceSession()
    let l:sessions = split(glob('~/.vim/sessions/session_*.vim'), '\n')
    if empty(l:sessions)
        echo "No sessions found!"
        return
    endif
    call sort(l:sessions, {a,b -> a > b ? -1 : 1})
    let l:choice = inputlist(map(copy(l:sessions), {i, v -> (i+1) . ': ' . fnamemodify(v, ':t')}))
    if l:choice > 0
        execute 'source' l:sessions[l:choice - 1]
    endif
endfunction

if argc() == 0
  autocmd VimEnter * call SourceSession()
endif

function! SaveSession(name)
    let l:session_name = a:name != '' ? a:name : fnamemodify(expand('%'), ':t')
    let l:session_name ='session_' . strftime('%Y-%m-%d_%H-%M') . '_' . l:session_name . '.vim'
    execute 'mksession! ~/.vim/sessions/'. l:session_name
    echo "Session saved as: " . l:session_name
endfunction

command! -nargs=? SaveSession call SaveSession(<f-args>)
EOF

# 🐞 Sample vimspector config
cat <<EOF > ~/.vimspector.json
{
  "configurations": {
    "Python: Launch Script": {
      "adapter": "debugpy",
      "configuration": {
        "request": "launch",
        "type": "python",
        "name": "Launch script",
        "program": "\${file}",
        "console": "integratedTerminal",
        "justMyCode": true,
        "python": "$PYTHON_VENV_DIR/bin/python3"
      }
    }
  }
}
EOF

# 🔁 Add aliases
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
echo 'alias vim="$HOME/.local/bin/nvim"' >> ~/.bashrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc

echo "✅ Done! Open Neovim with 'nvim' and run :PlugInstall"
nvim +PlugInstall
