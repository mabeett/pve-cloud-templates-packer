### VM disk configuration
vm_disk_storage_pool      = "local-zfs"
vm_disk_storage_pool_type = "zfspool"
vm_disk_type              = "virtio"
vm_scsi_controller        = "virtio-scsi-single"
vm_guest_disk_drive       = "/dev/vda"
vm_disk_size              = "3G"
vm_disk_cache_mode        = "none"
vm_disk_format            = "raw"
vm_disk_io_thread         = true

# CPU & Memory
vm_cores  = "1"
vm_memory = "1024"

# OS
cloud_img_url   = "https://cloud-images.ubuntu.com/minimal/daily/jammy/current/jammy-minimal-cloudimg-amd64.img"
cloud_init_user = "ubuntu"

# VM description
vm_name              = "ubuntu-2204-cloudimg-minimal-template-WIP"
template_name        = "ubuntu-2204-cloudimg-minimal"
template_description = "Ubuntu 22.04 minimal via packer"
vm_id                = 1000005
