#! /bin/bash
# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;; 
esac

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH";
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#####USER ADDED#####
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth;
HISTCONTROL=ignoredups:ignorespace:erasedups;

# append to the history file, don't overwrite it
shopt -s histappend;

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000;
HISTFILESIZE=2000;

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize;
shopt -s cdspell;

# Use . and .. instead of cd
# shopt -s autocd

# Run vim commands on the cli (not sure how it works)
# set -o vi

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lAh --color=auto'
    alias la='ls -lhA --color=auto'
    alias l='ls -CF --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

############~Custom Bash Prompt Info~############
# Add some colors
# BLK='\[\e[0;30m\]';   # Black
RED='\[\e[0;31m\]';   # Red
LRED='\[\e[0;91m\]';  # Light Red
GRN='\[\e[0;32m\]';   # Green
LGRN='\[\e[0;92m\]';  # Light Green
# YLW='\[\e[0;33m\]';   # Yellow
BLU='\[\e[0;34m\]';   # Blue
# LBLU='\[\e[0;94m\]';  # Light Blue
PUR='\[\e[0;35m\]';   # Purple
CYN='\[\e[0;36m\]';   # Cyan
WHT='\[\e[0;37m\]';   # White
# Bold colors
# BBLK='\[\e[1;30m\]'; # Black
# BRED='\[\e[1;31m\]'; # Red
# BGRN='\[\e[1;32m\]'; # Green
BYLW='\[\e[1;33m\]'; # Yellow
BBLU='\[\e[1;34m\]'; # Blue
BPUR='\[\e[1;35m\]'; # Purple
# BCYN='\[\e[1;36m\]'; # Cyan
BWHT='\[\e[1;37m\]'; # White
#clr='\e[0;00m';     # Reset bad
clr='\[\033[0m\]';   # Reset good

# Bash Prompt background = [COLORm\]
# Black background: 40
# Blue background: 44
# Cyan background: 46
# Green background: 42
# Purple background: 45
# Red background: 41
# White background: 47
# Yellow background: 43

# Bash Prompt text attributes
# Normal Text: 0
# Bold or Light Text: 1 (It depends on the terminal emulator.)
# Dim Text: 2
# Underlined Text: 4
# Blinking Text: 5 (This does not work in most terminal emulators.)
# Reversed Text: 7 (This inverts the foreground and background colors, so you’ll see black text on a white background if the current text is white text on a black background.)
# Hidden Text: 8

###################################
##########     TPUTS     ##########
###################################
# background color using ANSI escape
# bgBlack=$(tput setab 0);   # black
# bgRed=$(tput setab 1);     # red
# bgGreen=$(tput setab 2);   # green
# bgYellow=$(tput setab 3);  # yellow
# bgBlue=$(tput setab 4);    # blue
# bgMagenta=$(tput setab 5); # magenta
# bgCyan=$(tput setab 6);    # cyan
# bgWhite=$(tput setab 7);   # white

# foreground color using ANSI escape
# fgBlack=$(tput setaf 0);   # black
# fgRed=$(tput setaf 1);     # red
# fgGreen=$(tput setaf 2);   # green
# fgYellow=$(tput setaf 3);  # yellow
# fgBlue=$(tput setaf 4);    # blue
# fgMagenta=$(tput setaf 5); # magenta
# fgCyan=$(tput setaf 6);    # cyan
# fgWhite=$(tput setaf 7);   # white

# text editing options
# txBold=$(tput bold);       # bold
# txHalf=$(tput dim);        # half-bright
# txUnderline=$(tput smul);  # underline
# txEndUnder=$(tput rmul);   # exit underline
# txReverse=$(tput rev);     # reverse
# txStandout=$(tput smso);   # standout
# txEndStand=$(tput rmso);   # exit standout
# txReset=$(tput sgr0);      # reset attributes
###################################
###################################

# More Bash Prompt commands
# \a – A bell character
# \d – Date (day/month/date)
# \D{format} – Use this to call the system to respond with the current time
# \e – Escape character
# \h – Hostname (short)
# \H – Full hostname (domain name)
# \j – Number of jobs being managed by the shell
# \l – The basename of the shells terminal device
# \n – New line
# \r – Carriage return
# \s – The name of the shell
# \t – Time (hour:minute:second)
# \@ – Time, 12-hour AM/PM
# \A – Time, 24-hour, without seconds
# \u – Current username
# \v – BASH version
# \V – Extra information about the BASH version
# \w – Current working directory ($HOME is represented by ~)
# \W – The basename of the working directory ($HOME is represented by ~)
# \! – Lists this command’s number in the history
# \# – This command’s command number
# \$ – Specifies whether the user is root (#) or otherwise ($)
# \\– Backslash
# \[ – Start a sequence of non-displayed characters (useful if you want to add a command or instruction set to the prompt)
# \] – Close or end a sequence of non-displayed characters

# Check if starship installed, then run else check if podman accessible, else generic prompt
if hash starship 2> /dev/null; then
    eval "$(starship init bash)"
else        
    __prompt_command() {
        local EXIT="$?"  # This needs to be the first line
        
        if hash podman 2> /dev/null; then

            # NAMES=`podman ps -a | grep -wv NAMES`
            NAMES=`podman ps -a --format="STATUS\tNAMES\n{{.Status}}\t{{.Names}}" | sed 1d`
            
            # Get names of running containers
            if [ -n "$NAMES" ]; then
                stopped=$RED`echo "$NAMES" | awk '/Exited/ {print $(NF)}' | tr '\n' ' '`;
                created=$LBLU`echo "$NAMES" | awk '/Created/ {print $(NF)}' | tr '\n' ' '`;
                running=$LGRN`echo "$NAMES" | awk '/Up/ {print $(NF)}' | tr '\n' ' '`;
                # created=$LBLU"$(podman ps -af status=created --format '{{.Names}}' | tr '\n' ' ')";
                # stopped=$RED"$(podman ps -af status=exited --format '{{.Names}}' | tr '\n' ' ')";
                # running=$LGRN"$(podman ps -af status=running --format '{{.Names}}' | tr '\n' ' ')";
                # if [ -n "$(podman ps -a | grep -wv NAMES | wc -l)" ]; then
                    # stopped=$RED"$(podman ps -af status=exited | grep -wv NAMES | awk '{print $(NF)}' | sed -z 's/\n/ /g')";
                    # created=$LBLU"$(podman ps -af status=created | grep -wv NAMES | awk '{print $(NF)}' | sed -z 's/\n/ /g')";
                    # running=$LGRN"$(podman ps -af status=running | grep -wv NAMES | awk '{print $(NF)}' | sed -z 's/\n/ /g')";
                session_text=" $clr$running$created$stopped";
            else
                session_text=" ";
            fi
        else        
            # Checks if inside toolbox or distrobox or ssh or nothing
            if [ -f "/run/.toolboxenv" ]; then
                session_text=" $BPUR$(cat /run/.containerenv | grep -oP '(?<=name=\")[^\";]+') ";
            elif [ -f "/run/.containerenv" ]; then
                session_text=" $BYLW$(hostname -s) ";
            elif [ -n "$SSH_CLIENT" ]; then
                session_text=" $BWHT'SSH SESSION' ";
            else
                session_text=" ";
            fi
        fi
        
        # Check if running jobs in background, else just show history
        if [ -n "$(jobs -p)" ]; then
            lette="\!$clr$WHT:$GRN\j";
        else
            lette="\!";
        fi
        
        # Check if last command was successful, green, or not, red
        if [ $EXIT != 0 ]; then
            vlu="$RED$lette$LGRN";
        else
            vlu="$GRN$lette$LGRN";
        fi
        
        # Custom prompt
        PS1="$LGRN┌──[$vlu]$CYN\u$WHT@$LRED\h$clr\n$LGRN└──╼${session_text}$BBLU> $clr";
    }

    PROMPT_COMMAND=__prompt_command

fi
