#!/bin/bash

mkdir -p ~/.vim/colors

curl -o ~/.vim/colors/wombat256mod.vim https://raw.githubusercontent.com/flazz/vim-colorschemes/master/colors/wombat256mod.vim

mkdir -p ~/.vim/undodir

if ! grep -q "taylorsuccessor" ~/.vimrc; then
curl -o ~/.vimrc https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/vimrc
fi

echo "Vim setup is complete!"
