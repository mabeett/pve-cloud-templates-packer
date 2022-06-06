########################## proxmox login credentials ##########################
variable "proxmox_node" {
  type = string
}

variable "proxmox_user" {
  type = string
}

variable "proxmox_api_user" {
  type = string
}

variable "proxmox_token_id" {
  type = string
}

variable "proxmox_token" {
  type = string
}

variable "proxmox_url" {
  type = string
}

variable "proxmox_api_host" {
  type = string
}

####################### #livedistro installer iso settings ####################
variable "iso_file" {
  type = string
}

variable "iso_url" {
  type = string
}

variable "iso_checksum" {
  type = string
}

variable "iso_storage_pool" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "ssh_password" {
  type = string
}


######################## VM hardware definitions ##############################
######## disk drive definitions #######
variable "vm_disk_storage_pool" {
  type = string
}

variable "vm_disk_storage_pool_type" {
  type = string
}

variable "vm_disk_type" {
  type    = string
  default = "scsi"
}

variable "vm_disk_size" {
  type = string
}

variable "vm_disk_cache_mode" {
  type    = string
  default = "none"
}

variable "vm_disk_format" {
  type    = string
  default = "raw"
}

variable "vm_disk_io_thread" {
  type    = bool
  default = false
}

variable "vm_scsi_controller" {
  type = string
  # scsi_controller = "virtio-scsi-pci"
  default = "virtio-scsi-single"
}

variable "vm_guest_disk_drive" {
  type    = string
  default = "/dev/vda"
}

########### CPU and memory  ###########
variable "vm_cores" {
  type    = string
  default = "2"
}

variable "vm_memory" {
  type    = string
  default = "2048"
}

############# vm networking ###########
variable "vm_net_mac_address" {
  type    = string
  default = "be:ef:ca:fe:c0:c0"
}

variable "vm_net_model" {
  type    = string
  default = "virtio"
}

variable "vm_net_bridge" {
  type    = string
  default = "vmbr0"
}

variable "vm_net_mac_address2" {
  type    = string
  default = "be:ef:ca:fe:c0:c1"
}

variable "vm_net_model2" {
  type    = string
  default = "virtio"
}

variable "vm_net_bridge2" {
  type    = string
  default = "vmbr1"
}

######### display serial device ######
variable "vm_serial_device" {
  type    = string
  default = "serial0"
}


variable "guest_os_startup_validation_port" {
  type = number
}

########################## cloud init final setup  ############################
########################## setup made via ansible  ############################
variable "cloud_init_user" {
  type    = string
  default = "ubuntu"
}

variable "cloud_init_ipconfig" {
  type    = string
  default = "'ip=dhcp'"
}

variable "cloud_init_ssh_keys" {
  type = string
}

variable "ssh_root_login_file" {
  type = string
}

#########################################################
## Source cloud image to be installed on disk
variable "cloud_img_url" {
  description = "URI for the qemu image drive with the target OS - it must be accesible from vm"
  type        = string
}

variable "vm_name" {
  type = string
}

variable "vm_id" {
  type    = number
  default = 9999999
}

variable "template_name" {
  type = string
}

variable "template_description" {
  type = string
}

########################## wireguard definitions ##############################
variable "wireguard_server_listen_port" {
  type    = number
  default = 51820
}

variable "wireguard_server_address" {
  type    = string
  default = "100.127.255.0/27"
}

variable "wireguard_client_allowed_ip" {
  type    = string
  default = "100.127.255.2/32"
}

variable "net_lan_netmask" {
  type    = string
  default = "255.255.255.192"
}

variable "net_lan_ipaddr" {
  type    = string
  default = "192.168.3.1"
}

variable "wireguard_client_extra_routes" {
  description = "Extra routes to be added for wireguard client as CIDR notation"
  type        = list(string)
  default     = []
  # default = ["10.11.13.0/24", "172.21.13.0/24", "192.168.1.0/24"]
}


variable "wg_if_name" {
  description = "name for the wireguard interface"
  default     = "wg"
}

variable "local_destintation_files" {
  description = "local directory on which wireguard credentials and client config will be copied"
  default     = "/tmp/"
}

variable "wireguard_client_key" {
  description = "Client Private key for Wireguard - auto for automatic generation"
  default     = "auto"
  # default = "6H298PTubBRj6YaE6fjoCz4oJt0k2YSrvVfn2+EdEEQ="
}
variable "wireguard_client_pubkey" {
  description = "Client Public key for Wireguard - auto for automatic generation"
  default     = "auto"
  # default = "R0ke5U5csAfvYPldJMWQLv5mqe+CfWdbr62aZkw7nj8="
}

variable "wireguard_server_key" {
  description = "Server Private key for Wireguard - auto for automatic generation"
  default     = "auto"
  # default = "aJX8tGNISXKsKvWO3vUKuSd7kKTmn4rzswcA0C4ss0k="
}

variable "wireguard_server_pubkey" {
  description = "Server Public key for Wireguard - auto for automatic generation"
  default     = "auto"
  # default = "TUuu9a/u71TAPEqtLWZY1pKrPDo50KPF8BP+nCxmlDQ="
}

###############################################################################

source "proxmox-iso" "VM" {
  insecure_skip_tls_verify = "true"
  proxmox_url              = "https://${var.proxmox_api_host}:8006/api2/json"
  node                     = "${var.proxmox_node}"
  token                    = "${var.proxmox_token}"
  username                 = "${var.proxmox_api_user}!${var.proxmox_token_id}"

  cloud_init              = "true"
  cloud_init_storage_pool = "local-zfs"

  cores  = "${var.vm_cores}"
  memory = "${var.vm_memory}"

  # PLACEHOLDER: serial_port
  ## packer plugin does not soport setupt for serial port
  ## device. Workaround: ansible.
  # https://github.com/hashicorp/packer-plugin-proxmox/issues/41
  vga {
    type = "${var.vm_serial_device}"
  }

  scsi_controller = "${var.vm_scsi_controller}"
  disks {
    disk_size         = "${var.vm_disk_size}"
    format            = "${var.vm_disk_format}"
    storage_pool      = "${var.vm_disk_storage_pool}"
    storage_pool_type = "${var.vm_disk_storage_pool_type}"
    type              = "${var.vm_disk_type}"
    io_thread         = "${var.vm_disk_io_thread}"
  }

  ## use in case of having the file
  iso_file = "${var.iso_file}"
  # Use in case of no having the file
  unmount_iso      = true
  iso_storage_pool = "${var.iso_storage_pool}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  boot_command     = "${local.iso_boot_command}"

  network_adapters {
    firewall    = false
    bridge      = "${var.vm_net_bridge2}"
    model       = "${var.vm_net_model2}"
    mac_address = "${var.vm_net_mac_address2}"
  }
  network_adapters {
    firewall    = false
    bridge      = "${var.vm_net_bridge}"
    model       = "${var.vm_net_model}"
    mac_address = "${var.vm_net_mac_address}"
  }
  os         = "l26"
  qemu_agent = "true"

  ssh_timeout  = "90m"
  ssh_username = "${var.ssh_username}"
  ssh_password = "${var.ssh_password}"

  vm_name              = "${var.vm_name}"
  template_description = "${var.template_description} - built on ${timestamp()}"
  template_name        = "${var.template_name}"
  vm_id                = "${var.vm_id}"
}

build {
  sources = ["source.proxmox-iso.VM"]

  provisioner "ansible" {
    playbook_file = "../ansible/proxmox_cloud_init_config.yml"
    user          = "${var.ssh_username}"
    extra_arguments = [
      # "-vv",
      "-e ansible_python_interpreter=/usr/bin/python3.10",
      "-e proxmox_api_host=${var.proxmox_api_host} ",
      "-e proxmox_node=${var.proxmox_node} ",
      "-e proxmox_api_user=${var.proxmox_api_user} ",
      "-e proxmox_token_id=${var.proxmox_token_id} ",
      "-e proxmox_token=${var.proxmox_token} ",
      "-e cloud_init_user=${var.cloud_init_user} ",
      "-e cloud_init_password=${var.ssh_password} ",
      "-e cloud_init_ipconfig=${var.cloud_init_ipconfig} ",
      "-e cloud_init_ssh_keys=${var.cloud_init_ssh_keys} ",
      "-e vm_id=${var.vm_id} ",
      "-e wireguard_server_listen_port=${var.wireguard_server_listen_port} ",
      "-e vm_serial_device=${var.vm_serial_device}"
    ]
  }

  provisioner "ansible" {
    playbook_file = "../ansible/install_openwrt.yml"
    user          = "${var.ssh_username}"
    extra_arguments = [
      # "-vv",
      "-e ansible_python_interpreter=/usr/bin/python3.10",
      "-e cloud_img_url=${var.cloud_img_url} ",
      "-e root_password=${var.ssh_password}",
      "-e vm_disk=${var.vm_guest_disk_drive} "
    ]
  }

  provisioner "ansible" {
    playbook_file = "../ansible/openwrt_patches_via_sysrescuecd.yml"
    user          = "${var.ssh_username}"
    extra_arguments = [
      # "-vv",
      "-e ansible_python_interpreter=/usr/bin/python3.10",
      "-e cloud_img_url=${var.cloud_img_url} ",
      "-e root_password=${var.ssh_password}",
      "-e net_lan_netmask=${var.net_lan_netmask}",
      "-e net_lan_ipaddr=${var.net_lan_ipaddr}",
      "-e wireguard_server_listen_port=${var.wireguard_server_listen_port}",
      "-e wireguard_server_listen_address=wg.my.server.example.net",
      "-e wireguard_client_key=${var.wireguard_client_key}",
      "-e wireguard_client_pubkey=${var.wireguard_client_pubkey}",
      "-e wireguard_server_key=${var.wireguard_server_key}",
      "-e wireguard_server_pubkey=${var.wireguard_server_pubkey}",
      "-e wireguard_server_address=${var.wireguard_server_address}",
      "-e wireguard_client_allowed_ip=${var.wireguard_client_allowed_ip}",
      "--extra-vars=${local.wireguard_client_extra_routes}",
      "-e wg_if_name=${var.wg_if_name}",
      "-e local_destintation_files=${var.local_destintation_files}",
      "-e vm_disk=${var.vm_guest_disk_drive} "
    ]
  }

  provisioner "shell" {
    inline = ["bash -c 'nohup systemctl reboot 2>&1 1>/dev/null &'"]
  }

  provisioner "ansible" {
    playbook_file = "../ansible/openwrt_install_software.yml"
    user          = "${var.ssh_username}"
    extra_arguments = [
      # "-vv",
      "-e ssh_root_login_file='${var.ssh_root_login_file}' ",
      "-e vm_host=${build.Host} ",
      "-e wireguard_server_listen_port=${var.wireguard_server_listen_port} ",
      "-e wireguard_server_address=${var.wireguard_server_address}",
      "-e wireguard_client_allowed_ip=${var.wireguard_client_allowed_ip}",
      "-e net_lan_netmask=${var.net_lan_netmask}",
      "-e net_lan_ipaddr=${var.net_lan_ipaddr}",
      "-e local_destintation_files=${var.local_destintation_files}",
      "-e wg_if_name=${var.wg_if_name}",
      "-e vm_validate_port=${var.guest_os_startup_validation_port} "
    ]
  }

  # https://github.com/hashicorp/packer-plugin-proxmox/issues/83#issuecomment-1136569696
  # post-processor "shell-local" {
  #   command = "curl -s -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_user}!${var.proxmox_token_id}=${var.proxmox_token}' --data-urlencode delete=ide2 https://${var.proxmox_api_host}:8006/api2/json/nodes/${var.proxmox_node}/qemu/${var.vm_id}/config"
  # }

}
