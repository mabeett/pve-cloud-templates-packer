# Cloud Images templates for Proxmox PVE via packer

## Context

[Proxmox Virtual Environment](https://www.proxmox.com/en/proxmox-ve) (PVE) supports Cloud-init [[1](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#qm_cloud_init)][[2](https://pve.proxmox.com/wiki/Cloud-Init_Support)] for KVM Virtual Machines (VM).

PVE provides a [REST API](https://pve.proxmox.com/wiki/Proxmox_VE_API).

Currently the REST API does not offer importing hard drive images.
There are instructions for preparing Cloud-Init ready templates in proxmox using the node shell interface [[1](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#qm_cloud_init)][[2](https://pve.proxmox.com/wiki/Cloud-Init_Support)].

Packer offers a [community plugin](https://www.packer.io/plugins/builders/proxmox/iso) for PVE.

This project uses the packer plugin for PVE and Ansible provisioner for starting a [SystemRescueCD](https://www.system-rescue.org/) liveOS and there dumping a cloud image.

Since packer's plugin lacks of some features related to VM setup, this ones are done via [proxmox_kvm module](https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_kvm_module.html#ansible-collections-community-general-proxmox-kvm-module) provided by Ansible's community collection.

## How does this work?

Each packer subproject uses [proxmox-iso](https://www.packer.io/plugins/builders/proxmox/iso) builder.

Instead of booting with the target distro installer and using boot commands for launching a kickstart/preseed file the bootup is made with SystemRescueCD.

Theno, via Ansible provisioner QEMU-IMG is used for copying a cloud-ready OS content with all his packages and setup (as it would be dd).

Since some cloud-images does not have [QEMU Guest Agent installed](https://www.qemu.org/docs/master/interop/qemu-ga.html) the VM is restarted, thn the provisioner is connected to the target OS for installing the package. A custom ISO image is created with the same login credentials used for SystemRescueCD in order to make the login available and compatible with the target OS.

Packer proxmox builder cannot make some VM setups as serial drive, then Ansible is used for solving it.

## Requirements

This development has been made with

- bash
- [cloud-localds](https://code.launchpad.net/cloud-utils) tool from [cloud-image-utils](https://packages.ubuntu.com/impish/cloud-image-utils) ubuntu package.
- Packer 1.7.10
- Ansible 2.10.5
- Proxmox PVE 7.1 with his API token.

## Content

- `README.md`: This file
- `ubuntu_2004_cloudimg/`: packer directory for building ubuntu focal cloud-img.
- `ubuntu_2004_minimal/`: packer directory for building ubuntu focal minimal cloud-img.
- `debian_11_generic/`: packer directory for building debian bullseye cloud image.
- `debian_11_genericcloud/`: packer directory for building debian bullseye smaller cloud image.
- `common-pkr/`: common code for the previous dirs.
- `ansible/`: Ansible's playbooks used for the previous packer projects.
- `TODO`: possible and certain next steps.

## Use

- Install the required software as Packer or Ansible.
- Generate your API token for proxmox PVE.
- setup your `common-pkr/cloud-img-generic_via_sysrescuecd.private.auto.pkrvars.hcl` file with your credentials, you may read the example file.
- read and setup local files for the packer directory involved. Edit/generate `*.auto.pkrvars.hcl` or `variables.local.sh`, you may see the example files.
- execute build script

```
export distro="ubuntu_2004_cloudimg"
cd ${distro}/
bash build.sh
```

Depending on your proxmox node and the server with the cloud images bandwidth you might require download the disk image on your local net, save it and edit `cloud_img_url` variable.

### Adding a new image/template

You may make symbolic links to files from [common-pkr](common-pkr/) directory as it's made on [ubuntu_2004_minimal](ubuntu_2004_minimal/) directory.

## Know bugs and Future work

See [TODO](TODO) file.

## Other work

This are other project/resources for solving part or entirely this work:

- https://gist.github.com/chriswayg/43fbea910e024cbe608d7dcb12cb8466
- https://gist.github.com/chriswayg/b6422dcc69cb3b7e41f2998f1150e1df
- https://cloudalbania.com/posts/2022-01-homelab-with-proxmox-and-packer/
