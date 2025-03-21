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

variable "iso_type" {
  type    = string
  default = "ide"
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
variable "cpu_type" {
  type    = string
  default = ""
}

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

######### display serial device ######
variable "vm_serial_device" {
  type    = string
  default = "serial0"
}

variable "vm_pool" {
  type    = string
  default = ""
}

############################ cloud init fake drive  ###########################
###########  for starting guest OS and running there some operations ##########
variable "temp_cinit_net_config_file" {
  type = string
}

variable "temp_cinit_user_data_file" {
  type = string
}

variable "temp_cinit_meta_data_file" {
  type = string
}

variable "temp_cinit_device" {
  type = string
}

variable "temp_cinit_iso_storage_pool" {
  type = string
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

variable "vm_growpart_after_qemuimg" {
  description = "defines if growroot partition with growpart - used in ansible"
  type        = string
  default     = "true"
}

variable "vm_growpart_root_part_number" {
  description = "Partition number to be resize after disk dump depends on vm_growpart_after_qemuimg"
  type        = number
  default     = 1
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

source "proxmox-iso" "VM" {
  insecure_skip_tls_verify = "true"
  proxmox_url              = "https://${var.proxmox_api_host}:8006/api2/json"
  node                     = "${var.proxmox_node}"
  token                    = "${var.proxmox_token}"
  username                 = "${var.proxmox_api_user}!${var.proxmox_token_id}"

  cloud_init              = "true"
  cloud_init_storage_pool = "local-zfs"

  cpu_type = "${var.cpu_type}"
  cores    = "${var.vm_cores}"
  memory   = "${var.vm_memory}"

  serials = ["socket"]
  vga {
    type = "${var.vm_serial_device}"
  }

  scsi_controller = "${var.vm_scsi_controller}"
  disks {
    disk_size    = "${var.vm_disk_size}"
    format       = "${var.vm_disk_format}"
    storage_pool = "${var.vm_disk_storage_pool}"
    type         = "${var.vm_disk_type}"
    io_thread    = "${var.vm_disk_io_thread}"
  }

  boot_iso {
    type             = "${var.iso_type}"
    iso_storage_pool = "${var.iso_storage_pool}"
    iso_checksum     = "${var.iso_checksum}"
    ## use in case of having the iso file available in the PVE storage
    iso_file = "${var.iso_file}"
    ## use in case of downloading the file from http server.
    # iso_url           = "${var.iso_url}"
    unmount           = true
    keep_cdrom_device = false
    # there is a bug or server/client missconfiguration which returns
    # "--> proxmox-iso.VM: unexpected EOF\npanic: runtime error: invalid memory address or nil pointer dereference"
    # iso_download_pve = true
  }

  boot_command = "${local.iso_boot_command}"

  # cloud-init ephemeral device
  additional_iso_files {
    type             = "${var.temp_cinit_device}"
    iso_storage_pool = "${var.temp_cinit_iso_storage_pool}"
    cd_label         = "cidata"
    cd_files = [
      "${var.temp_cinit_net_config_file}",
      "${var.temp_cinit_user_data_file}",
      "${var.temp_cinit_meta_data_file}"
    ]
    unmount           = true
    keep_cdrom_device = false
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
  template_description = "${var.template_description}\n\n---\n\nbuilt via [pve-cloud-templates-packer](https://github.com/mabeett/pve-cloud-templates-packer) (or a fork)\n\n${timestamp()}"
  template_name        = "${var.template_name}"
  vm_id                = "${var.vm_id}"
  pool                 = "${var.vm_pool}"
}

build {
  sources = ["source.proxmox-iso.VM"]

  ## Current community.general collection does not handle cloud-init properly
  # https://github.com/ansible-collections/community.general/issues/7136
  # provisioner "ansible" {
  #   playbook_file = "../ansible/proxmox_cloud_init_config.yml"
  #   user          = "${var.ssh_username}"
  #   extra_arguments = [
  #     # "-vv",
  #     "-e proxmox_api_host=${var.proxmox_api_host} ",
  #     "-e proxmox_node=${var.proxmox_node} ",
  #     "-e proxmox_api_user=${var.proxmox_api_user} ",
  #     "-e proxmox_token_id=${var.proxmox_token_id} ",
  #     "-e proxmox_token=${var.proxmox_token} ",
  #     "-e cloud_init_user=${var.cloud_init_user} ",
  #     "-e cloud_init_password=${var.ssh_password} ",
  #     "-e cloud_init_ipconfig=${var.cloud_init_ipconfig} ",
  #     "-e cloud_init_ssh_keys=${var.cloud_init_ssh_keys} ",
  #     "-e vm_id=${var.vm_id} "
  #   ]
  # }

  provisioner "ansible" {
    playbook_file = "../ansible/install_via_qemu_img.yml"
    user          = "${var.ssh_username}"
    extra_arguments = [
      # "-vv",
      "-e cloud_img_url=${var.cloud_img_url} ",
      "-e growpart_after_qemuimg=${var.vm_growpart_after_qemuimg}",
      "-e root_part_number=${var.vm_growpart_root_part_number}",
      "-e vm_disk=${var.vm_guest_disk_drive} "
    ]
  }

  provisioner "shell" {
    inline = ["bash -c 'shutdown -t 1 -r'"]
  }

  provisioner "shell-local" {
    inline = ["sleep 5"]
  }

  provisioner "ansible" {
    playbook_file = "../ansible/cloud_init.yml"
    user          = "${var.ssh_username}"
    extra_arguments = [
      # "-vv",
      "-e ansible_python_interpreter=/usr/bin/python3",
      "-e ssh_root_login_file='${var.ssh_root_login_file}' ",
      "-e vm_host=${build.Host} ",
      "-e vm_validate_port=${var.guest_os_startup_validation_port} "
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "TEMPLATE_NAME=${var.template_name}"
    ]
    scripts = [
      "clean_files.sh"
    ]
  }
}
