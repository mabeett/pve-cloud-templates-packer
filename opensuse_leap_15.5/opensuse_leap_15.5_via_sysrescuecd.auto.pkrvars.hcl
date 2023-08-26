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
vm_cores  = "1"
vm_memory = "1024"

# OS
# cloud_img_url                = "http://192.168.0.21/cloud-images/openSUSE-Leap-15.5-Minimal-VM.x86_64-Cloud.qcow2"
cloud_img_url                = "https://opensuse.mirror.garr.it/mirrors/opensuse/distribution/leap/15.5/appliances/openSUSE-Leap-15.5-Minimal-VM.x86_64-Cloud.qcow2"
vm_growpart_root_part_number = 3

# cloud_init_user = "cloud-user"

# VM description
vm_name              = "opensuse-leap-linux-15-5-cloudimg-template-WIP"
template_name        = "opensuse-leap-linux-15-5-cloudimg"
template_description = "Opensuse-leap linux 15.5 via packer\n\n[info](https://get.opensuse.org/leap/15.5/?type=server#download)"
vm_id                = 1100016
