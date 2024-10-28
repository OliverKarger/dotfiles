#/usr/bin/zsh

# Check if zsh is installed
if [ ! -f /usr/bin/zsh ];
then
	echo "zsh needs to be installed!" >&2
	exit 1
fi

# yay package manager
# 	required for AUR packages
pacman -S git base-devel yay

# yay/pacman packages
pacman -S alacritty neovim
yay install spacenavd
