# shellcheck disable=SC2046,SC2086,SC2125
_setup_ssh_agent() {
  local keys=~/.ssh/deex*.key
  ## `timeout` prevents bashrc hangup when
  ## SSH_AUTH_SOCK is set but ssh-agent is dead
  timeout 2 ssh-add $keys &>/dev/null \
  || eval $(ssh-agent) >/dev/null \
  || echo "cannot start ssh agent"

  ssh-add $keys &>/dev/null \
  || echo "no ssh keys"
}

## skip ssh-agent on non-interactive bashrc
## this prevents ram thrashing due to frequent logins
[[ $_SSH_ =~ i ]] || _setup_ssh_agent
