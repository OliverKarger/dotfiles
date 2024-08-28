# Update
echo -n "Running Updates..."
apt-get update -y 1> /dev/null
echo "DONE"

echo -n "Running Upgrades..."
apt-get upgrade -y 1> /dev/null
echo "DONE"

# Install and Setup ZSH
echo -n "Checking if ZSH is installed at /usr/bin/zsh..."
if ! test -f /usr/bin/zsh; 
then
	echo "NOT FOUND - installing"
	apt-get install -y zsh 1> /dev/null
else
	echo "FOUND"
fi

# Install zsh-autosuggestions
echo -n "Installing zsh-autosuggestions"
apt-get install -y zsh-autosuggestions
echo "DONE"

echo -n "Checking Default Shell to ZSH..."
chsh -s $(which zsh)
echo "DONE"

# Install and Setup NVIM
echo -n "Checking if Neovim is installed..."
if ! test -f /usr/bin/nvim.appimage; 
then
	echo "NOT FOUND - installing"
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage 1> /dev/null
	chmod +x nvim.appimage
	mv nvim.appimage /usr/bin/nvim.appimage
else
	echo "FOUND"
fi

echo -n "Checking for Neovim Environment Variables in ~/.zshrc"
if ! grep -q "alias=nvim=/usr/bin/nvim.appimage" ~/.zshrc; 
then
	echo "FIXED"
	echo "alias nvim=/usr/bin/nvim.appimage" >> ~/.zshrc
else
	echo "OK"
fi

# Clone .dotfiles from my personal Repo
echo -n "Cloning Dotfiles..."
mkdir -p /tmp/dotfiles
git clone --quiet https://git.oliver-karger.de/oliverkarger/.dotfiles.git /tmp/dotfiles 1>/dev/null

mkdir -p ~/.config/nvim
cp -r /tmp/dotfiles/nvim ~/.config/nvim
rm -rf /tmp/dotfiles
echo "DONE"

# Install Vim-Plug
echo -n "Installing VIM-Plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 1> /dev/null
echo "DONE"

# Install NVIM Plugins
echo -n "Installing Neovim Plugins..."
/usr/bin/nvim.appimage +PlugInstall
echo "DONE"

# Setup NVIM in Git
echo -n "Configuring Git..."
git config --global core.editor /usr/bin/nvim.appimage
echo "DONE"

# Neofetch (MOTD)
echo -n "Checking if Neofetch is installed..."
if ! test -f /usr/bin/neofetch; then
	echo "NOT FOUND - installing"
	apt-get install -y neofetch 1> /dev/null
else
	echo "FOUND"
fi

echo "DONE"
