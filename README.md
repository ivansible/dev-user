# Role ivansible.dev_user

This role configures remote host and remote user for development.
It makes some common bash aliases for remote user and installs
common development packages (git, build-essentials, etc).
If `dev_user_install_keys` is true, this role will also
enable private SSH keys for remote user.

The role will additionally install:
  - gzip, unzip, unrar
  - git
  - build essential packages
  - [ngrok](https://ngrok.com/)
  - github's [hub](https://github.com/github/hub)
  - gz-encrypt.sh and gz-decrypt.sh scripts


## Requirements

This role needs private SSH key files be accessible by ansible.
Normally these are placed under the `files/secret` directory next to
the playbook (or linked therein).


## Variables

Available variables are listed below, along with default values.


    dev_user_git_fullname: <ansible_user_id>
    dev_user_git_email: <ansible_user_id>@<inventory_hostname>

Full name and email to fill in git configuration.


    dev_user_install_keys: true

If this setting is *true* , the role will install private SSH keys
for remote user under `~/.ssh`. Otherwise, this step will be skipped.

    dev_user_keys_files: <playbook_dir>/files/secret/*.key

The list of private key files to install. It can be overridden in
`group_vars/permitted/secret/dev-user.yml`. The list must not be empty,
if `dev_user_install_keys` is *true*.

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


    dev_user_setup_system: true

This boolean triggers installation of common development packages
(git, build-essentials, etc) and known host keys on the remote machine.


    dev_user_known_host_list: ['github.com', ...]

If this list is not empty, add `github.com` and friends to the global
list of known hosts (usually `/etc/ssh/ssh_known_hosts`).
Setting this parameter to empty list will skip this step.


## Tags

- `dev_user_bashrc` - Customize `~/.bashrc.local`
- `dev_user_gitconfig` - Customize `~/.gitconfig`
- `dev_user_install_keys` - Install SSH keys
- `dev_user_ssh_config` - Customize `~/.ssh/config`
- `dev_user_setup_system` - Install development packages and known host keys
- `dev_user_known_hosts` - Update global list of known hosts
- `dev_user_install_backup` - install backup-restore scripts on target host


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

    ansible-playbook plays-all/run-role.yml -e role=ivansible.dev_user -l vag2

See settings in `host_vars/vag2/secret/test.dev_user.yml`


## License

MIT


## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
