# ivansible.dev_user

[![Github Test Status](https://github.com/ivansible/dev-user/workflows/Molecule%20test/badge.svg?branch=master)](https://github.com/ivansible/dev-user/actions)
[![Travis Test Status](https://travis-ci.org/ivansible/dev-user.svg?branch=master)](https://travis-ci.org/ivansible/dev-user)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-ivansible.dev__user-68a.svg?style=flat)](https://galaxy.ansible.com/ivansible/dev_user/)

This role configures remote host and remote user for development.
It creates some common bash aliases for remote user.
If `dev_user_install_keys` is true, it will also enable private SSH keys.
The role will additionally install `gz-encrypt.sh` and `gz-decrypt.sh` scripts


## Requirements

This role needs private SSH key files accessible by ansible.
Normally these are placed under the `files/secret/keys` directory
next to the playbook (or linked therein).


## Variables

Available variables are listed below, along with default values.

    real_ssh_port: <optional>
This optional setting lets the user override an auto-detected ssh port value,
which may be incorrect if ansible is run by the hashicorop packer or through
a reverse ssh or port forwarder. An incorrect value is generally harmless
though, as the role uses it only to fill in a comment.

    dev_user_git_fullname: <ansible_user_id>
    dev_user_git_email: <ansible_user_id>@<inventory_hostname>

Full name and email to fill in git configuration.


    dev_user_install_keys: true

If this setting is *true* , the role will install private SSH keys
for remote user under `~/.ssh`. Otherwise, this step will be skipped.

    dev_user_authorized_keys_files: <playbook_dir>/files/secret/keys/*.key
The list of private key files to authorize.
It can be overridden in `group_vars/permitted/secret/dev-user.yml`.

    dev_user_installed_keys_files: <playbook_dir>/files/secret/keys/*.key
The list of private key files to install.
The list must not be empty, if `dev_user_install_keys` is *true*.
By default, it is the first of authorized keys.

    dev_user_require_keys: true

By default this is _true_ and script will abort if the list of private
key files is empty. Set this to _false_ if you want to enable empty
list of keys.

    dev_user_group_vars: {}
    dev_user_host_vars: {}
    dev_user_extra_vars: {}

    dev_user_group_secrets: {}
    dev_user_host_secrets: {}
    dev_user_extra_secrets: {}

Dictionaries of exported variable names/values that will be added to the
user's bashrc.


    dev_user_rev_ssh_host: revssh

The role will search inventory for this host name. If found, it will
be added to the local user ssh config file.


    dev_user_known_host_list: ['github.com', ...]

If this list is not empty, add `github.com` and friends to the global
list of known hosts (usually `/etc/ssh/ssh_known_hosts`).
Setting this parameter to empty list will skip this step.


## Tags

- `dev_user_bashrc` - customize `~/.bashrc.local`
- `dev_user_tmux` - customize tmux
- `dev_user_gitconfig` - customize `~/.gitconfig`
- `dev_user_pubkeys` - authorize public SSH keys
- `dev_user_install_keys` - install SSH keys
- `dev_user_ssh_config` - customize `~/.ssh/config`
- `dev_user_ssh_all` - all tasks related to SSH keys
- `dev_user_known_hosts` - update global list of known hosts
- `dev_user_install_backup` - install backup-restore scripts
- `dev_user_all` - all of the above


## Dependencies

- `ivansible.lin_base` -- for `lin_ssh_keys_files`
- `ivansible.backup_base` -- for `install_scripts.yml`


## Example Playbook

    - hosts: vag2
      roles:
        - role: ivansible.dev_user
          dev_user_install_keys: false
          dev_user_extra_vars:
            http_proxy: http://my.proxy.com:8080


## Testing

    molecule test [-s default]
    ivantory-role .dev_user vagrant-box


## License

MIT


## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
