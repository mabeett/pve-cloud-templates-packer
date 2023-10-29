### VM disk configuration
vm_disk_storage_pool = "local-zfs"
vm_disk_type         = "virtio"
vm_scsi_controller   = "virtio-scsi-single"
vm_guest_disk_drive  = "/dev/vda"
vm_disk_size         = "4G"
vm_disk_cache_mode   = "none"
vm_disk_format       = "raw"
vm_disk_io_thread    = true

# CPU & Memory
vm_cores  = "1"
vm_memory = "1024"

# OS
cloud_img_url   = "https://cloud-images.ubuntu.com/mantic/current/mantic-server-cloudimg-amd64.img"
cloud_init_user = "ubuntu"

# VM description
vm_name              = "ubuntu-2310-cloudimg-template-WIP"
template_name        = "ubuntu-2310-cloudimg"
template_description = "Ubuntu 23.10 (Mantic Minotaur) via packer\n\n[info](https://cloud-images.ubuntu.com/mantic/current/)"
vm_id                = 1000016
