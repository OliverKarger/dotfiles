export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Themes
ZSH_THEME="robbyrussell"

# Autocorrection
ENABLE_CORRECTION="false"

# Plugins
plugins=(battery branch colorize git ssh virtualenv)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set preferred Editor for local and remote Connections
export EDITOR='nvim'

# Compilation Flags
export ARCHFLAGS="-arch $(uname -m)"

# C/C++ Compilers
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# Terminal Colors
export TERM="screen-256color"

# Aliases
export ll='ls -la'

# Fix for spacenavd with Wayland/XWayland
if [ -n "$XAUTHORITY" ]; then
    rm -f "$HOME/.Xauthority";     
    ln -s $XAUTHORITY "$HOME/.Xauthority";
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ "$TMUX" = "" ]; then exec tmux; fi
neofetch
