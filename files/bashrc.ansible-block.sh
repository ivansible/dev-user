#.

# ensure history without duplicates
HISTCONTROL=ignoreboth

export PATH=~/bin:$PATH

# aliases

alias c='clear'
alias g='git'
alias gnp='git --no-pager'
alias h='head'
alias l='ls --color=auto --group-directories-first'
alias md='mkdir'
alias m='less'
alias pg='ps -efa | grep -i'
alias rmf='/bin/rm -f'
alias rmrf='/bin/rm -rf'
alias t='tail'
alias tf='tail -F'
alias tma='tmux attach'
alias v='vim'
alias wl='wc -l'

alias jc='journalctl'
alias sc='sudo systemctl'
alias scu='systemctl --user'
alias sus='sudo su -'

alias anp='ansible-playbook'
alias ang='ansible-galaxy'
alias angii='ansible-galaxy import ivansible'
alias vact='. .venv/bin/activate'

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

# settings

export BROWSER='firefox'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='-R'

#export http_proxy="http://user:password@host.com:port"
#export https_proxy="$http_proxy"

#export AWS_ACCESS_KEY_ID=""
#export AWS_SECRET_ACCESS_KEY=""
#export AWS_DEFAULT_REGION=""
#export GITHUB_TOKEN=""
#export VULTR_TOKEN=""

#.
