#! /usr/bin/env zsh

# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/zshenv

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# export LANG=C
# export TERMINAL="alacritty"
export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"
export BROWSER="flatpak-spawn --host flatpak run io.gitlab.librewolf-community"

[ -f "$DOTFILES/install_config" ] && source "$DOTFILES/install_config"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=1000                    # Maximum events for internal history
export SAVEHIST=1000                    # Maximum events in history file

# other software
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"

# Man pages
export MANPAGER='nvim +Man!'
