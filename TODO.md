# TODO

## Add Virtio RNG

 - wait integration [of feature](https://github.com/hashicorp/packer-plugin-proxmox/pull/195) in packer plugin, see [releases](https://github.com/hashicorp/packer-plugin-proxmox/releases)
 - hardware on proxmox
 - software considerations: kernel 5.10 version?

## CPU type study

 - according [to qemu](https://qemu.readthedocs.io/en/latest/system/qemu-cpu-models.html#other-non-recommended-x86-cpus) the default one - kvm64 is non-recommended.
 - ( cpu_type  flag )

## Remove dummy cloud init drive

Remove dummy cloud init drive after packer from proxmox server

## add more distros

 - rocky?
   - https://computingforgeeks.com/generate-rocky-linux-qcow2-image-for-openstack-kvm-qemu/
 - flatcar?
 - rancher?
 - Alpine?


# DONE

## more distros

 - opensuse leap #11
 - oracle linux 9.2 #9
 - Ubuntu Noble https://cloud-images.ubuntu.com/noble/

## take prev project as template

## validate hardware definition

 - src
   - https://pve.proxmox.com/wiki/Cloud-Init_Support
   - https://gist.github.com/chriswayg/b6421dcc69cb3b7e41f2998f1150e1df

## apply notes and automation

command should/can be installed via ansible
