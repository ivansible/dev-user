# ivansible.dev_user

[![Github Test Status](https://github.com/ivansible/dev-user/workflows/test/badge.svg?branch=master)](https://github.com/ivansible/dev-user/actions)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-ivansible.dev__user-68a.svg?style=flat)](https://galaxy.ansible.com/ivansible/dev_user/)

This role configures remote host and remote user for development.
It creates some common bash aliases for remote user.
It will also enable private SSH keys, if any.
The role will additionally install `gz-encrypt.sh` and `gz-decrypt.sh` scripts


## Requirements

This role needs private SSH key files accessible by ansible.
Normally these are placed under the `files/secret/keys` directory
next to the playbook (or linked therein).


## Variables

Available variables are listed below, along with default values.

    dev_user_git_fullname: <ansible_user_id>
    dev_user_git_email: <ansible_user_id>@<inventory_hostname>

Full name and email to fill in git configuration.


    dev_user_ssh_keys_accept: <derived from ssh_keys_accept>
The list of private key files to accept.
Normally this is derived from `ssh_keys_accept` (string or list),
which can be provided as a playbook CLI argument.
Defaults to the list of playbook ssh keys `<playbook_dir>/files/secret/keys/*.key`
recorded in `lin_ssh_keys_files` and inherited from the role `lin_base`.

    dev_user_ssh_keys_deploy: <first accepted ssh key or derived from ssh_keys_deploy>
The list of private key files to install.
By default, it's the first accepted ssh key, if any.

    dev_user_ssh_keys_revoke: <derived from ssh_keys_revoke>
The list of obsolete ssh keys (public or private) to decommit.
By default none.

    dev_user_ssh_interactive: false
    dev_user_ssh_keys_interactive: <derived from ssh_keys_interactive>
Subset of accepted ssh keys with interactive features enabled such as bash aliases.
By default none.

    dev_user_ssh_keys_git: <derived from ssh_keys_git>
    dev_user_authorized_git_repos: [github.com, gitlab.com]
Configure given ssh keys (actually, the first one) to access given git remotes.

    dev_user_group_vars: {}
    dev_user_host_vars: {}
    dev_user_extra_vars: {}

    dev_user_group_secrets: {}
    dev_user_host_secrets: {}
    dev_user_extra_secrets: {}

Dictionaries of exported variable names/values that will be added to the
user's bashrc.

    dev_user_totp_keys: {}
A dictionary of TOTP keys in the form `{e-mail: base32-key, ...}`
for use with [OATH tool](wiki.archlinux.org/*/Google_Authenticator#Code_generation)
or [Google authenticator](https://google-authenticator.com).

    dev_user_rev_ssh_host: revssh

The role will search inventory for this host name. If found, it will
be added to the local user ssh config file.


### Optional Variables

    real_ssh_port: <optional>

This optional setting allows user to override auto-detected ssh port,
which may be incorrect if ansible is run by the HashiCorp packer
or through a reverse ssh tunnel or port forwarder.
An incorrect value is generally harmless though, as the role uses it
only to fill in a comment.


## Tags

- `dev_user_bashrc` - customize `~/.bashrc.local`
- `dev_user_tmux` - customize tmux
- `dev_user_gitconfig` - customize `~/.gitconfig`
- `dev_user_ssh_keys` - authorize public SSH keys, install SSH keys
- `dev_user_ssh_config` - customize `~/.ssh/config`
- `dev_user_ssh_all` - all tasks related to SSH and keys
- `dev_user_utils` - install backup-restore scripts, OATH tool, various utilities
- `dev_user_all` - all of the above


## Dependencies

- `ivansible.lin_base` -- for `lin_ssh_keys_files`
- `ivansible.backup_base` -- for `install_scripts.yml`


## Example Playbook

    - hosts: vag2
      roles:
        - role: ivansible.dev_user
          dev_user_extra_vars:
            http_proxy: http://my.proxy.com:8080


## Testing

    molecule test [-s default]
    ivantory-role .dev_user vagrant-box


## License

MIT


## Author Information

Created in 2018-2021 by [IvanSible](https://github.com/ivansible)
