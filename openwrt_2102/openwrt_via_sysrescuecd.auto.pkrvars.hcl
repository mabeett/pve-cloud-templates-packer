### VM disk configuration
vm_disk_storage_pool      = "local-zfs"
vm_disk_storage_pool_type = "zfspool"
vm_disk_type              = "virtio"
vm_scsi_controller        = "virtio-scsi-single"
vm_guest_disk_drive       = "/dev/vda"
vm_disk_size              = "500M"
vm_disk_cache_mode        = "none"
vm_disk_format            = "raw"
vm_disk_io_thread         = true

# CPU & Memory
vm_cores  = "1"
vm_memory = "1024"

# OS
# cloud_img_url   = "https://downloads.openwrt.org/releases/21.02.2/targets/x86/64/openwrt-21.02.2-x86-64-generic-squashfs-rootfs.img.gz"
cloud_img_url = "https://downloads.openwrt.org/releases/21.02.3/targets/x86/64/openwrt-21.02.3-x86-64-generic-ext4-combined.img.gz"

# needed but not used in openwrt
cloud_init_user = "ubuntu"

# VM description
vm_name              = "openwrt-21023-wg-template-WIP"
template_name        = "openwrt-21023-wg"
template_description = "OpenWRT via packer"
vm_id                = 1100000
