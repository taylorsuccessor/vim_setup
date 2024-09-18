#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/vim_setup.sh)
# bash <(curl -s https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/nginx/nginx_logs_enable_disable.sh)



curl -o ~/.vim/colors/wombat256mod.vim https://raw.githubusercontent.com/flazz/vim-colorschemes/master/colors/wombat256mod.vim
curl -o ~/.custom_vimrc https://raw.githubusercontent.com/taylorsuccessor/vim_setup/main/vimrc


mkdir -p ~/.vim/colors


mkdir -p ~/.vim/undodir

if ! grep -q "custom_vimrc" ~/.vimrc; then
    echo 'source ~/.custom_vimrc' >> ~/.vimrc
fi

echo "Vim setup is complete!"
