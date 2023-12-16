# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh

# +---------+
# | General |
# +---------+

# Load more completions
fpath=($ZDOTDIR/zsh/plugins/zsh-completions/src $fpath)

# Use modern completion system
autoload -Uz compinit

#### TRYING THIS OUT ####
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

##########################
# zmodload zsh/complist
# compinit

_comp_options+=(globdots)

# Edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^x^e" edit-command-line

# Fix backwards delete Courtesy Brodie Robertson
bindkey "^?" backward-delete-char
# Fix delete Courtesy chris@machine
bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[3~"  delete-char
bindkey '^[3;5~' delete-char

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# +---------+
# | zstyles |
# +---------+

# man zshcompsys
# man zshmodules
# man zshcompwid
# man zshoptions
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# zstyle ':completion:*' menu select=long
# eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' special-dirs true
zstyle :compinstall filename '/home/steven/.config/zsh/completion.zsh'
