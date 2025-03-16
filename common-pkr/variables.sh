## shared variables with generate iso script and packer

export PKR_VAR_ssh_password="password123"
export PKR_VAR_ssh_root_login_file="/etc/ssh/sshd_config.d/0000_rootlogin.conf"
export PKR_VAR_ssh_username="root"
export PKR_VAR_vm_net_bridge="vmbr0"
export PKR_VAR_vm_net_mac_address="be:ef:ca:fe:c0:ca"
export PKR_VAR_guest_os_startup_validation_port="9008"
export PKR_VAR_temp_cinit_device="ide"
export PKR_VAR_temp_cinit_iso_storage_pool="local"

export Cloud_Init_dns_address="192.168.0.1"
export Cloud_Init_dns_search="pkr.localnet"
export PKR_VAR_cloud_init_ipconfig="'ip=dhcp'"
export Cloud_Init_net_name="eth0"
