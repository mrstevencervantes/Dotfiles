#!/usr/bin/env bash

# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/zshrc

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey '^ ' autosuggest-accept # auto accept suggestion

# +---------+
# | Options |
# +---------+

setopt CORRECT

#### Directory Stack ####
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt MENU_COMPLETE        # Automatically highlight first item of menu

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt auto_list                 # automatically list choices on ambiguous completion
setopt auto_menu                 # automatically use menu completion
setopt always_to_end             # move cursor to end if word had one match
setopt hist_reduce_blanks        # remove superfluous blanks from history items
setopt inc_append_history        # save history entries as soon as they are entered

# +--------+
# | COLORS |
# +--------+

# Override colors
eval "$(dircolors -b)"

# +---------+
# | ALIASES |
# +---------+

# load aliases
source $ZDOTDIR/.zsh_aliases

# +------------+
# | COMPLETION |
# +------------+

# load completions
# https://github.com/zsh-users/zsh-completions
source $ZDOTDIR/completion.zsh
# bindkey -M menuselect '\r' .accept-line
# zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands
# bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# +-------------+
# | SUGGESTIONS |
# +-------------+

source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# +-----------+
# | FUNCTIONS |
# +-----------+

#### USER FUNCTIONS ####
# Print history of search word
function hg() {
    history | grep "$1";
}

# Get command help with cheat.sh
# https://github.com/chubin/cheat.sh
search() {
    curl -s https://cheat.sh/"$1";
}

learn() {
    curl -s https://cheat.sh/"$1"/:learn;
}

# Rate.sx fun
# courtesy Brodie Robinson
rate() {
    curl -s rate.sx/"$1";
}

# Get dictionary definiton
# courtesy Brodie Robinson
define() {
    curl -s dict://dict.org/d:"$1";
}

function colors() {
    for color in {000..255}; do
        print -P "$color: %F{$color} Foreground %f%K{$color} Background %k"
    done
}

# DISABLE_AUTO_TITLE="true"

# function set_terminal_title() {
#  echo -en "\e]2;$@\a"
# }

# +--------+
# | PROMPT |
# +--------+

if hash starship 2> /dev/null; then
    eval "$(starship init zsh)"
else

    function toolbox() {
    # Function to echo toolbox name
       echo $(grep -oP "(?<=name=\")[^\";]+" /run/.containerenv)
    }

    function running_jobs() {
        if [[ -n "$(jobs -p)" ]]; then
            lette='%!%f%B%F{white}:%f%b%F{green}%j%f'
        else
            lette='%!%f'
        fi

        echo '%!%f%B%F{white}:%f%b%F{green}%j%f'
        #echo "$lette"
    }

    PROMPT='%F{green}['$(running_jobs)'%F{green}]%f%F{cyan}%n%f@%F{red}'$(toolbox)'%f %F{blue}%B>%b%f '
    # RPROMPT="%Bboold test%b Not bold"

fi

PATH="/home/steven/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/steven/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/steven/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/steven/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/steven/perl5"; export PERL_MM_OPT;

# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+

# https://github.com/zsh-users/zsh-syntax-highlighting
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
