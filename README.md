# cis-rhel8


[![Build Status](https://travis-ci.org/jbertozzi/ansible-role-cis-rhel8.svg?branch=master)](https://travis-ci.org/jbertozzi/ansible-role-cis-rhel8)
[![Ansible Role](https://img.shields.io/badge/role-jbertozzi.cis--rhel8-blue.svg)](https://galaxy.ansible.com/jbertozzi/cis-rhel8/)

Configure a RHEL 8 server to conform [CIS Benchmarks](https://www.cisecurity.org/benchmark/red_hat_linux/).

Be carefull before to use this role, it might break your systems.

## Role Variables

### Item

There is one boolean variable per item `cis_rhel8_<section>_<subitem1>_<subitem2>(_<subitem3>)?` that will apply or not the associated remediation. By default the role will remediate all the items. Be carefull to set proper variables to false if your systems have specific a specific need.

For instance, if you don't want to setup a bootloader password (_1.5.2 - Ensure bootloader password is set_), set the variable `cis_rhel8_1_5_2` to `false`.

### Customization

For some items, you can configure one or more variables. For example, if you decide to set up a bootloaded password, you can set your own or decide to reset it with:

* `cis_rhel8_grub_password: mynewsecurepassword` (this variable should probably be vaulted)
* `cis_rhel8_reset_grub_password: true`

By default, those customization variables are set to the recommended value by the CIS Benchmarks.


## Example Playbooks

Apply all remediations using default values:

```
$ cat cis.yml
---
- hosts: rhel8_servers
  roles:
    - role: cis-rhel8
$ ansible-playbook cis.yml
```

Apply only section 1 (_Initial Setup_):

```
$ cat cis.yml
---
- hosts: rhel8_servers
  vars:
    cis_rhel8_5_2_11: false
    roles:
     - role: cis-rhel8
$ ansible-playbook cis.yml -t section1
```

Apply only level 1 items, do not remediate a few items (_1.4.1 Ensure AIDE is installed_ and _5.2.6 Ensure SSH X11 forwarding is disabled_) and customize _5.2.5 Ensure SSH LogLevel is appropriate_:

```
$ cat cis.yml
---
- hosts: rhel8_servers
  vars:
    cis_rhel8_1_4_1: false
    cis_rhel8_5_2_6: false
    cis_rhel8_sshd_log_level: DEBUG
    roles:
     - role: cis-rhel8
$ ansible-playbook cis.yml -t level1
```

## License

BSD

## Author Information

Jérémy Bertozzi <jeremy.bertozzi@gmail.com>
