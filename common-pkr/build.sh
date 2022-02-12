#!/bin/env bash

set -e

. variables.sh

set -u
set -o nounset
# set -x

TIMESTAMP=$(date "+%s")
TMPDIR="tmp/${TIMESTAMP}"
CI_FILE="cloudinit_${TIMESTAMP}.iso"

###############################################################################
##### sourced from example template of proxmox generated CD disk  #############
# Generates network-config file
get_network_config() {
    mac_address="${PKR_VAR_vm_net_mac_address}"
    dns_address="${Cloud_Init_dns_address}"
    dns_search="${Cloud_Init_dns_search}"
    net_name="${Cloud_Init_net_name}"
    cat >${1} << EOF
version: 1
config:
    - type: physical
      name: ${net_name}
      mac_address: '${mac_address}'
      subnets:
      - type: dhcp4
    - type: nameserver
      address:
      - '${dns_address}'
      search:
      - '${dns_search}'
EOF
}

# Generates user-data file
get_user_data() {
    # ssh_pwauth
    ##  The ssh_pwauth config key determines whether or not sshd will be configured to accept password
    # chpasswd
    ## The chpasswd config key accepts a dictionary containing either or both of expire and list.

    password="${PKR_VAR_ssh_password}"
    user="${PKR_VAR_ssh_username}"
    root_login_file="${PKR_VAR_ssh_root_login_file}"
    vm_validate_port="${PKR_VAR_guest_os_startup_validation_port}"
    package_upgrade="true"
    ssh_key=""
    cat >${1} << EOF
#cloud-config

hostname: packer-building-process
manage_etc_hosts: true
disable_root: false
user: ${user}
ssh_pwauth: yes
password: ${password}
chpasswd:
  expire: False
users:
  - root
package_upgrade: ${package_upgrade}
runcmd:
  - echo 'PermitRootLogin yes' > ${root_login_file}
  - service sshd restart
  - bash -c 'cd /opt/ && sudo -u www-data nohup python3 -m http.server ${vm_validate_port} 2>&1 1>/dev/null &'
ssh:
  emit_keys_to_console: false
no_ssh_fingerprints: true
EOF
}

# Generats meta-data file
get_meta_data() {
    instance_id="beeffcaaaaaaaaaaaaaaaaaaaaa${TIMESTAMP}ffe"
    cat >${1} << EOF
instance-id: ${instance_id}
EOF
}

clean_tmp(){
    exval=${?}
    rm -rf ${TMPDIR}
    exit ${exval}
}

###############################################################################

trap clean_tmp EXIT

mkdir -p "${TMPDIR}"
get_network_config  "${TMPDIR}/network-config"
get_user_data       "${TMPDIR}/user-data"
get_meta_data       "${TMPDIR}/meta-data"

# cloud-localds -v --network-config  network-config            --filesystem iso output        user-data              meta-data
cloud-localds   -v --network-config "${TMPDIR}/network-config" --filesystem iso "${TMPDIR}/${CI_FILE}"  "${TMPDIR}/user-data" "${TMPDIR}/meta-data"

shasum=$(sha256sum "${TMPDIR}/${CI_FILE}" | awk '{print "sha256:"$1}')
export PKR_VAR_temp_cinit_iso_checksum="${shasum}"
export PKR_VAR_temp_cinit_iso_url="file://$(pwd)/${TMPDIR}/${CI_FILE}"

time packer validate .
time packer build .

# TODO: delete temp iso cloud init drive from proxmox.
>&2 echo "TODO: delete iso generated drive"
>&2 echo " storage: ${PKR_VAR_temp_cinit_iso_storage_pool}"
>&2 echo " iso    : ${CI_FILE}"
