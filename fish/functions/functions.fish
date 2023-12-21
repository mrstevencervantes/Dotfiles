function hg
  history | grep $argv
end

function search
  clear
  curl -s https://cheat.sh/$1;
end

function learn
  clear;
  curl -s https://cheat.sh/$1/:learn;
end

function rate
  clear;
  curl -s rate.sx/$1;
end

function define
  clear;
  curl -s dict://dict.org/d:$1;
end

