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
cloud_img_url   = "https://cloud-images.ubuntu.com/minimal/daily/noble/current/noble-minimal-cloudimg-amd64.img"
cloud_init_user = "ubuntu"

# VM description
vm_name              = "ubuntu-2404-cloudimg-minimal-template-WIP"
template_name        = "ubuntu-2404-cloudimg-minimal"
template_description = "Ubuntu 24.04 (Noble Numbat) minimal via packer\n\n[info](https://cloud-images.ubuntu.com/minimal/daily/noble/current/#noble-minimal-cloudimg-amd64.img)"
vm_id                = 1000017