## ensure history without duplicates
HISTCONTROL=ignoreboth

if [ "$TERM" = screen ] && [ -n "$PROMPT_COMMAND" ]; then
    export PROMPT_COMMAND=""
fi

## common bash functions

ph() {
    pygmentize "$@" | less -XCSR
}

pssh() {
    local hosts="${1//,/ }"; shift
    parallel-ssh -H "$hosts" -i "$@"
}

## simple replacement for google authenticator
totp() {
    for _tok in ${TOTP_KEYS//,/ }; do
        echo "$(oathtool --totp -b "${_tok/*:/}") ${_tok/:*}"
    done
}

sys-upgrade() {
    local cmd
    for cmd in update upgrade dist-upgrade autoremove clean; do
        sudo env DEBIAN_FRONTEND=noninteractive apt-get -qy $cmd
    done
}

aws-dist() {
    awless list distributions |
    awk -F\| '/Deployed/{print $3,$9}' |
    sed -r 's/\[ID:|,PublicDNS://g' |
    awk '{print $2 "\t" $1}' |
    sort
}

## get compatible with recent systemd
which resolvectl >/dev/null || \
alias resolvectl='sudo systemd-resolve'
