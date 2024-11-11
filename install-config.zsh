#!/usr/bin/zsh

clear
echo "The Following Applications are required so that this Script runs correctly"
echo "--------------------------------------------------------------------------"
echo "\t-Neovim"
echo "\t-ZSH"
echo "\t-OhMyZSH"
echo "\t-Alacritty"
echo "\t-spacenavd"
echo "\t-fancontrol"


# Check if zsh is installed
if [ ! -f /usr/bin/zsh ]; 
then
	echo "zsh needs to be installed!" >&2
	exit 1
fi

# zsh
echo "Install ZSH Config? (y/n) "
read zsh_yn
if [ $zsh_yn = "y" ];
then
    if [ -f ~/.zshrc ]; 
    then
	    # if a file exists, create a backup
	    rm ~/.zshrc
    fi
    ln -s $(pwd)/.zshrc ~/.zshrc
fi

# neovim
echo "Install Neovim Config? (y/n) "
read neovim_yn
if [ $neovim_yn = "y" ];
then
    mkdir -p ~/.config/nvim/vim-plug

    if [ -f ~/.config/nvim/init.vim ]; 
    then
	    rm -f ~/.config/nvim/init.vim
    fi
    ln -s $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

    if [ -f ~/.config/nvim/vim-plug/plugins.vim ]; 
    then
	    rm -f ~/.config/nvim/vim-plug/plugins.vim
    fi
    ln -s $(pwd)/nvim/vim-plug/plugins.vim ~/.config/nvim/vim-plug/plugins.vim
fi

echo "Install Alacritty Config? (y/n) "
read alacritty_yn
if [ $alacritty_yn = "y" ];
then
    mkdir -p ~/.config/alacritty/themes

    if [ -f ~/.config/alacritty/alacritty.toml ]; 
    then
	    rm -f ~/.config/alacritty/alacritty.toml
    fi

    ln -s $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

    if [ -f ~/.config/alacritty/themes/ayu_dark.toml ]; 
    then
	    rm -f ~/.config/alacritty/themes/ayu_dark.toml
    fi

    ln -s $(pwd)/alacritty/themes/ayu_dark.toml ~/.config/alacritty/themes/ayu_dark.toml

    if [ -f ~/.config/alacritty/themes/gruvbox_material_dark.toml ]; 
    then
	    rm -f ~/.config/alacritty/themes/gruvbox_material_dark.toml
    fi

    ln -s $(pwd)/alacritty/themes/gruvbox_material_dark.toml ~/.config/alacritty/themes/gruvbox_material_dark.toml
fi

echo "Install spacenavd Config? (y/n) "
read spacenavd_yn
if [ $spacenavd_yn = "y" ];
then
    if [ -f /etc/spnavrc ]; 
    then
	    rm /etc/spnavrc	
    fi
    
    ln -s $(pwd)/spnavrc /etc/spnavrc

    echo "Reload spacenavd? (y/n)"
    read reload_spacenavd_yn
    if [ $reload_sapcenavd_yn = "y" ];
    then
        systemctl daemon-reload
        systemctl restart spacenavd
    fi
fi

echo "Install FanControl Config? (y/n) "
read fancontrol_yn
if [ $fancontrol_yn = "y" ];
then
    if [ -f /etc/fancontrol ];
    then
	    rm /etc/fancontrol
    fi
    ln -s $(pwd)/fancontrol /etc/fancontrol
fi
