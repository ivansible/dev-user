## ensure history without duplicates
HISTCONTROL=ignoreboth

[ "$TERM" = screen -a -n "$PROMPT_COMMAND" ] && export PROMPT_COMMAND=""

ph()
{
    pygmentize $1 | less
}

totp()
{
    for _tok in ${TOTP_KEYS//,/ }; do
        echo "$(oathtool --totp -b ${_tok/*:/}) ${_tok/:*}"
    done
}
