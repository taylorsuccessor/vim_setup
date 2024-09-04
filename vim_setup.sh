#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/vim_setup.sh)


mkdir -p ~/.vim/colors

curl -o ~/.vim/colors/wombat256mod.vim https://raw.githubusercontent.com/flazz/vim-colorschemes/master/colors/wombat256mod.vim

mkdir -p ~/.vim/undodir

curl -o ~/.custom_vimrc https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/vimrc
if ! grep -q "custom_vimrc" ~/.vimrc; then
    echo 'source ~/.custom_vimrc' >> ~/.vimrc
fi

echo "Vim setup is complete!"
