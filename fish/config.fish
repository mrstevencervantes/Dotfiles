if status is-interactive
    sudo dnf update --refresh;
    clear;
end

function fish_prompt
  # Check the status of the previous command
  if test $status -eq 0
    set status_color green;
  else
    set status_color red;
  end

  # Get command history number
  set command_history (history | wc -l);
  
  # Get running job count, if any
  set running_jobs (jobs | wc -l);
  if test $running_jobs -gt 0
    set jobs_displayed ":$running_jobs";
  else
    set jobs_displayed "";
  end
  
  # Build prompt string
  set_color green; echo -n '[';
  set_color $status_color; echo -n $command_history$jobs_displayed;
  set_color green; echo -n ']';
  set_color cyan; echo -n (whoami); set_color normal;
  echo -n '@';
  set_color red; echo -n (hostname); set_color normal;
  set_color blue; echo -n ' > '; set_color normal;
end

set -x BROWSER flatpak-spawn --host flatpak run io.gitlab.librewolf-community;
set -x EDITOR nvim;
set -x VISUAL nvim;
set -x manpager nvim +Man!;

if command -sq eza
    alias ls='eza';
    alias l='eza -lh --all --group-directories-first';
    alias ll='eza -lh --all --all --group-directories-first';
    alias la='eza -lh --all --all --group-directories-first';
else 
    alias ll='ls -lAh --color=auto';
    alias la='ls -lhA --color=auto';
    alias l='ls -CF --color=auto';
end

if command -sq bat
    export BAT_THEME="Solarized (light)";
    alias cat='bat';
end

# confirm before overwriting something
alias cp='cp -iv'; # Courtesy of c@m
alias mv='mv -iv'; # Courtesy of Distrotube
alias rm='rm -iv'; # Courtesy of Distrotube
