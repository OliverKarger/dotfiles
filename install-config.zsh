#!/usr/bin/zsh

# Check if zsh is installed
if [ ! -f /usr/bin/zsh ]; 
then
	echo "zsh needs to be installed!" >&2
	exit 1
fi

# zsh
if [ -f ~/.zshrc ]; 
then
	# if a file exists, create a backup
	rm ~/.zshrc
fi
ln -s $(pwd)/.zshrc ~/.zshrc

# neovim
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

# alacritty
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

# spacenavd
if [ -f /etc/spnavrc ]; 
then
	rm /etc/spnavrc	
fi
ln -s $(pwd)/spnavrc /etc/spnavrc

systemctl daemon-reload
systemctl restart spacenavd
