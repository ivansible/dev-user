#.

# ensure history without duplicates
HISTCONTROL=ignoreboth

export PATH=~/bin:$PATH

export BROWSER='firefox'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='-R'

# local aliases

alias c='clear'
alias g='git'
alias h='head'
alias l='ls --color=auto --group-directories-first'
alias md='mkdir'
alias m='less'
alias pg='ps -efa | grep -i'
alias rmf='/bin/rm -f'
alias rmrf='/bin/rm -rf'
alias t='tail'
alias tf='tail -F'
alias v='vim'
alias wl='wc -l'

alias vact='. .venv/bin/activate'
alias anp='ansible-playbook'
alias jc='journalctl'
alias sc='sudo systemctl'
alias sus='sudo su -'
alias dr='docker'
alias dman='docker-machine'
alias vg='vagrant'

ph() { pygmentize $1 | less; }

[ "$TERM" = screen -a -n "$PROMPT_COMMAND" ] && export PROMPT_COMMAND=""

# ssh-agent
ssh-add -l &>/dev/null \
|| eval $(ssh-agent) >/dev/null \
|| echo cannot start ssh agent
ssh-add ~/.ssh/vanko-*.key &>/dev/null \
|| echo no ssh keys

#.
