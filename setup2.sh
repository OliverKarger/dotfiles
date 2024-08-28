log_file=~/setup.sh.log

echo "do you want to perform updates?"
select yn in "yes" "no"; do
    case $yn in
        yes ) apt-get update -yy >> $log_file;;
        no ) break;;
    esac
done

echo "do you want to perform upgrades?"
select yn in "yes" "no"; do
    case $yn in
        yes ) apt-get upgrades -yy >> $log_file;;
        no ) break;;
    esac
done

echo -n "checking if zsh is installed..."
if ! test -f /usr/bin/zsh;
then
    echo "missing"
    echo -n "installing zsh..."
    apt-get install -yy zsh >> $log_file
    if test -f /usr/bin/zsh;
    then
        echo "completed"
    else
        echo "failed"
        exit
    fi
else
    echo "completed"
fi

echo -n "installing zsh autosuggesstions..."
apt-get install -y zsh-autosuggestions >> $log_file
echo "completed"

echo "do you want to set zsh as your default shell?"
select yn in "yes" "no"; do
    case $yn in
        yes ) chsh -s $(which zsh) >> $log_file;;
        no ) break;;
    esac
done

echo "checking if neovim is installed..."
if ! test -f /usr/bin/nvim.appimage;
then
    echo "missing"
    echo -n "installing neovim"
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage >> $log_file
    chmod +x nvim.appimage
    mv nvim.appimage /usr/bin/nvim.appimage
    if test -f /usr/bin/nvim.appimage;
    then
        echo "installed"
        echo -n "checking for neovim environment variables..."
        if ! grep -q "alias=nvim=/usr/bin/nvim.appimage" ~/.zshrc; 
        then
            echo "fixed"
            echo "alias nvim=/usr/bin/nvim.appimage" >> ~/.zshrc
        else
            echo "ok"
        fi
    else
        echo "failed"
        exit
    fi
fi

echo -n "installing vim-plug for neovim..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >> $log_file
if test -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim;
then
    echo "done"
else
    echo "error"
    exit
fi

echo "done"

echo -n "cloning my dotfiles repository..."
git clone https://git.oliver-karger.de/oliverkarger/dotfiles.git /tmp/dotfiles
if test -f /tmp/dotfiles;
then
    echo "done"
    echo -n "copying dotfiles for neovim..."
    mkdir -p ~/.config/nvim
    cp -r /tmp/dotfiles/nvim/* ~/.config/nvim
    echo "done"
else
    echo "failed"
    exit
fi

echo -n "installing neovim plugins"
/usr/bin/nvim.appimage +PlugInstall >> $log_file
echo "done"

if test -f /usr/bin/git;
then
    echo "do you want to configure neovim as the default message editor for git?"
    select yn in "yes" "no"; do
        case $yn in
            yes ) git config --global core.editor /usr/bin/nvim.appimage >> $log_file;;
            no ) break;;
        esac
    done
fi
