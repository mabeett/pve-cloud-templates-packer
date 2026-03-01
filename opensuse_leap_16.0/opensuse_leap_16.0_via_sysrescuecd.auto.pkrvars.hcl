### VM disk configuration
vm_disk_storage_pool = "local-zfs"
vm_disk_type         = "virtio"
vm_scsi_controller   = "virtio-scsi-single"
vm_guest_disk_drive  = "/dev/vda"
vm_disk_size         = "2G"
vm_disk_cache_mode   = "none"
vm_disk_format       = "raw"
vm_disk_io_thread    = true

# CPU & Memory
cpu_type  = "Westmere"
vm_cores  = "1"
vm_memory = "1024"

# OS
# cloud_img_url                = "http://192.168.0.21/cloud-images/Leap-16.0-Minimal-VM.x86_64-Cloud.qcow2"
cloud_img_url                = "https://download.opensuse.org/distribution/leap/16.0/appliances/Leap-16.0-Minimal-VM.x86_64-Cloud.qcow2"
vm_growpart_root_part_number = 3

# cloud_init_user = "cloud-user"

# VM description
vm_name              = "opensuse-leap-linux-16.0-cloudimg-template-WIP"
template_name        = "opensuse-leap-linux-16.0-cloudimg"
template_description = "Opensuse-leap linux 16.0 via packer\n\n[info](https://get.opensuse.org/leap/16.0/?type=server#download) and [more info](https://download.opensuse.org/distribution/leap/16.0/appliances/)"
vm_id                = 1100019
