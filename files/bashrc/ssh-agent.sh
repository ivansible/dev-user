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

_setup_ssh_agent
