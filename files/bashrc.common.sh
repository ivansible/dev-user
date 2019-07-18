# ensure history without duplicates
HISTCONTROL=ignoreboth

[ "$TERM" = screen -a -n "$PROMPT_COMMAND" ] && export PROMPT_COMMAND=""

ph() { pygmentize $1 | less; }

# ssh-agent
ssh-add -l &>/dev/null \
|| eval $(ssh-agent) >/dev/null \
|| echo cannot start ssh agent
ssh-add ~/.ssh/deex*.key &>/dev/null \
|| echo no ssh keys
