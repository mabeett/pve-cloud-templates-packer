### VM disk configuration
vm_disk_storage_pool = "local-zfs"
vm_disk_type         = "virtio"
vm_scsi_controller   = "virtio-scsi-single"
vm_guest_disk_drive  = "/dev/vda"
vm_disk_size         = "40G"
vm_disk_cache_mode   = "none"
vm_disk_format       = "raw"
vm_disk_io_thread    = true

# CPU & Memory
cpu_type  = "Westmere"
vm_cores  = "1"
vm_memory = "1024"

# systemrescuecd will start without serial
vm_serial_device = "qxl"
iso_boot_command_suffix = ""

# OS
# cloud_img_url             = "http://192.168.0.21/cloud-images/OL9U2_x86_64-kvm-b197.qcow"
cloud_img_url             = "https://yum.oracle.com/templates/OracleLinux/OL9/u2/x86_64/OL9U2_x86_64-kvm-b197.qcow"
vm_growpart_after_qemuimg = "false"

# cloud_init_user = "cloud-user"

# VM description
vm_name              = "oracle-linux-9-2-cloudimg-template-WIP"
template_name        = "oracle-linux-9-2-cloudimg"
template_description = "Oracle linux 9.2 via packer\n\n[info](https://yum.oracle.com/oracle-linux-templates.html)"
vm_id                = 1100015
