export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Themes
ZSH_THEME="robbyrussell"

# Autocorrection
ENABLE_CORRECTION="false"

# Plugins
plugins=(battery branch colorize git ssh)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set preferred Editor for local and remote Connections
export EDITOR='nvim'

# Compilation Flags
export ARCHFLAGS="-arch $(uname -m)"

# C/C++ Compilers
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# Aliases
export ll='ls -la'

# Fix for spacenavd with Wayland/XWayland
if [ -n "$XAUTHORITY" ]; then
    rm -f "$HOME/.Xauthority";     
    ln -s $XAUTHORITY "$HOME/.Xauthority";
fi

if [ "$TMUX" = "" ]; then tmux; fi
neofetch
