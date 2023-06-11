### VM disk configuration
vm_disk_storage_pool = "local-zfs"
vm_disk_type         = "virtio"
vm_scsi_controller   = "virtio-scsi-single"
vm_guest_disk_drive  = "/dev/vda"
vm_disk_size         = "3G"
vm_disk_cache_mode   = "none"
vm_disk_format       = "raw"
vm_disk_io_thread    = true

# CPU & Memory
vm_cores  = "1"
vm_memory = "1024"

# OS
# cloud_img_url = "http://192.168.0.21/cloud-images/debian-12-generic-amd64.qcow2"
cloud_img_url   = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
cloud_init_user = "debian"

# VM description
vm_name              = "debian-12-cloudimg-template-WIP"
template_name        = "debian-12-cloudimg"
template_description = "Debian 12 via packer"
vm_id                = 1000013
