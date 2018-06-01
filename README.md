# ivansible.dev-user

This role configures remote host and remote user for development.
It makes some common bash aliases for remote user and installs
common development software (git, build-essentials, etc).
If remote host belongs to the `workspace` group, this role will
also enable private SSH keys for remote user.

## Requirements

This role needs private SSH key files be accessible by ansible.
Normally these are placed under the `files/secret` directory next to
the playbook (or linked therein) and by default have names `vanko-*.key`.

## Variables

Available variables are listed below, along with default values.

    dev_user_install_keys: true

If this setting is *true* and if the remote host belongs in the `workspace`
group, this role will install private SSH keys for remote user under `~/.ssh`.
Otherwise, this step will be skipped.

    dev_user_keys_files: <playbook_dir>/files/secret/vanko-*.key

The list of private key files to install. It can be overridden in
`group_vars/workspace/secret/dev-user.yml`.

    dev_user_add_known_hosts: true

If *true*, add `github.com`, `gitlab.com` and `bitbucket.org`
to the list of known hosts.

    dev_user_setup_system: true

This boolean triggers installation of common development software
(git, build-essentials, etc) on the remote host.

    dev_user_git_fullname: <ansible_user_id>
    dev_user_git_email: <ansible_user_id>@<inventory_hostname>

Full name and email to fill in git configuration.

## Tags

- `dev_user_bashrc`
- `dev_user_gitconfig`
- `dev_user_known_hosts`
- `dev_user_install_keys`
- `dev_user_setup_system`

## Dependencies

None

## Example Playbook

    - hosts: dock2
      roles:
        - { role: ivansible.dev-user, dev_user_install_keys: false }

## Testing

    ansible-playbook plays-all/test-role.yml -e role=ivansible.dev-user -l dock2

See settings in `host_vars/dock2/secret/test-role.dev-user.yml`

## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
