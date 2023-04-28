#! /bin/bash
# .bash_aliases

# some more ls aliases
# check for exa and bat
if hash podman 2> /dev/null; then
    # Custom Docker/Podman format command
    alias dpps='podman ps -a --format="$(tput bold)${fgRed}---> ${txReset}ID: {{.ID}}\n   NAME: {{.Names}}\n  IMAGE: {{.Image}}\n  PORTS: {{.Ports}}\nCOMMAND: {{.Command}}\nCREATED: {{.CreatedAt}}\n STATUS: {{.Status}}\n\n"';
else
    export BAT_THEME="Solarized (light)"
    alias ls='exa'
    alias ld='exa -lh --all -D'
    alias ll='exa -lh --long --all --group-directories-first'
    alias li='exa -lh --long --icons --all --group-directories-first'
    alias cat='bat'
fi

if hash fzf 2> /dev/null; then
    # junegunn/seoul256.vim (dark)
    export FZF_DEFAULT_OPTS='--color=bg+:#3F3F3F,bg:#4B4B4B,border:#6B6B6B,spinner:#98BC99,hl:#719872,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,preview-bg:#3F3F3F,prompt:#98BEDE,hl+:#98BC99'
fi

alias dd='dd status=progress'
alias _='sudo'
alias _i='sudo -i'
alias please='sudo'
alias fucking='sudo'

# confirmation aliases
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

### Custom Functions ###
# Print some system info
function sys_info () {
  clear;
#  word_count=$(rpm-ostree status | grep LayeredPackages | wc -l);
#  added_total=$(($word_count - 1));
#  word_count=$(rpm-ostree status | grep RemovedBasePackages | wc -l);
#  removed_total=$(($word_count -1));
  printf "\n";
  printf "   %s\n" "IP ADDR: $(curl -s ifconfig.me)"; # ipv6 curl ifconfig.co/
  printf "   %s\n" "HOST ADDR: $(hostname -I | awk '{print $1}')";
  printf "   %s\n" "USER: $(echo $USER)";
  printf "   %s\n" "DATE: $(date)";
  printf "   %s\n" "UPTIME: $(uptime -p)";
  printf "   %s\n" "HOSTNAME: $(hostname -f)";
#  printf "   %s\n" "CPU: $(awk -F: '/model name/{print $2}' | head -1)";
  printf "   %s\n" "KERNEL: $(uname -rms)";
#  printf "   %s\n" "ADDED PACKAGES: $added_total";
#  printf "   %s\n" "REMOVED PACKAGES: $removed_total";
#  printf "   %s\n" "RESOLUTION: $(xrandr | awk '/\*/{printf $1" "}')";
  printf "   %s\n" "MEMORY: $(free -m -h | awk '/Mem/{print $3"/"$2}')";
  printf "\n";
}

# Print history of search word
function hg() {
  if hash fzf 2> /dev/null; then
    ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --header="History Search" | sed -re 's/^\s*[0-9]+\s*//' | python3 -c "print(f'{input()}')"
  else
    history | grep "$1";
  fi
}

# Get command help with cheat.sh
# https://github.com/chubin/cheat.sh
# courtesy Brodie Robinson
search() {
    clear;
    curl -s https://cheat.sh/"$1";
}

# courtesy Brodie Robinson
learn() {
    clear;
    curl -s https://cheat.sh/"$1"/:learn;
}

# Rate.sx fun
# courtesy Brodie Robinson
rate() {
    clear;
    curl -s rate.sx/"$1";
}

# Get dictionary definition
# courtesy Brodie Robinson
define() {
    clear;
    curl -s dict://dict.org/d:"$1";
} 

# Fix bug in Silverblue/Kinoite
alias update-fixer='sudo grub2-mkconfig';

# toolbox, distrobox and podman functions
tent() {
    clear;
    toolbox enter "$1";
}

dent() {
    clear;
    distrobox enter "$1";
}

# Stop containers/toolbox/distrobox
pstop() {
  if hash podman 2> /dev/null; then
    # podman ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r podman stop
    podman ps -af status=running --format '{{.Names}}' | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r podman stop
  else
    if [[ $# -eq 0 ]]; then
      podman stop -a;
    else
      for var in "$@"
      do
        podman stop "$var"
      done
    fi
  fi
}

# Remove containers/toolbox/distrobox
prm() {
  if hash podman 2> /dev/null; then
    # podman ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r podman rm
    podman ps -a --format="{{.Names}}" | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r podman rm
  else
    if [[ $# -eq 0 ]]; then
      podman rm -a;
    else
      for var in "$@"
      do
        podman rm "$var"
      done
    fi
  fi

}

# Remove container/toolbox/distrobox images
prmi() {
  if hash podman 2> /dev/null; then
    podman images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r podman rmi
  else
    if [[ $# -eq 0 ]]; then
      podman rmi -a;
    else
      for var in "$@"
      do
        podman rmi "$var"
      done
    fi
  fi
}

# Docker/Podman aliases
alias pimg='podman images -a'
alias pvol='podman volume ls'
alias pnet='podman network ls'

# Fedora Toolbox aliases
alias macd="toolbox run -c tools macchanger -s enp88s0"
alias tbup="toolbox run -c tools sudo dnf upgrade"
alias tldr="toolbox run -c tools tldr"
alias neofetch="toolbox run -c tools neofetch"

# KDE/Konsole Terminal
if hash konsoleprofile 2> /dev/null; then
    alias firefox="konsoleprofile tabtitle='Firefox' && sleep 0.1 && konsoleprofile TabColor=Orange && toolbox run -c tools firefox"
    alias htop="konsoleprofile tabtitle='HTOP' && sleep 0.1 && konsoleprofile TabColor=Yellow && toolbox run -c tools htop"
    alias powertop="konsoleprofile tabtitle='PowerTOP' && sleep 0.1 && konsoleprofile TabColor=Blue && toolbox run -c tools sudo powertop"
    alias stacer="konsoleprofile tabtitle='Stacer' && sleep 0.1 && konsoleprofile TabColor=Purple && toolbox run -c tools stacer"
    alias tools="clear && konsole --new-tab && konsoleprofile tabtitle='Tools' && sleep 0.1 && konsoleprofile TabColor=Yellow && toolbox enter tools"
    alias bpytop="konsoleprofile tabtitle='PyTOP' && sleep 0.1 && konsoleprofile TabColor=Green && toolbox run -c tools bpytop"
# Xfce/Xfce4 Terminal
elif hash xfce4-terminal 2> /dev/null; then
    alias tools="xfce4-terminal -e 'bash -c \"toolbox enter tools \"' -T "Tools" --maximize"
    alias bpytop="xfce4-terminal -T PyTOP --maximize --command 'toolbox run -c tools bpytop'"
else
    alias tools='toolbox enter tools'
    alias bpytop='tools run -c tools bpytop'
fi
