#!/bin/env bash
# This hook is needed because target OS has an specific  python version older than certain Ansible requisites

# Latest Accepted Ansible version 9 (ansible core 2.16.x, Python <= 3.16)

ansible-playbook -v ../ansible/check-version.yml  -e max_full=2.16.999 --connection=local || ( >/dev/stderr echo "use an older python version" ; exit 33 )

[ -f variables.user.local.sh ] && . variables.user.local.sh
:
