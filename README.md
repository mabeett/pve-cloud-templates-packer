# Cloud Images templates for Proxmox PVE via packer


## Context

Proxmox Virtual Environment (PVE) supports Cloud-init [[1](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#qm_cloud_init)][[2](https://pve.proxmox.com/wiki/Cloud-Init_Support)] for KVM Virtual Machines.

PVE proviedes a REST API [[3](https://pve.proxmox.com/wiki/Proxmox_VE_API)].

Currently the REST API does not offer importing hard drive images.
There are instructions for preparing Cloud-Init ready templates in proxmox using the node shell interface [[1](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#qm_cloud_init)][[2](https://pve.proxmox.com/wiki/Cloud-Init_Support)].

Packer offers a community plugin for PVE [[4](https://www.packer.io/plugins/builders/proxmox/iso)].

This repository uses the packer plugin and Ansible provisioner for starting a SystemRescueCD [[5](https://www.system-rescue.org/)] liveOS and there dumping a cloud image.

Since packer's plugin lacks of some features some VM setup are donw via Ansible's PVE collections.

## Requirements

This development has been made with

- Packer  1.7.10
- Ansible 2.10.5
- proxmox PVE 7.1 with his API token.

## Other work

This are other project/resources for solving part or entirely this work:

 - https://gist.github.com/chriswayg/43fbea910e024cbe608d7dcb12cb8466
 - https://gist.github.com/chriswayg/b6421dcc69cb3b7e41f2998f1150e1df
 - https://cloudalbania.com/posts/2022-01-homelab-with-proxmox-and-packer/

## Content

- `README.md`: This file
- `ubuntu_2004_cloudimg/`: packer directory for building ubuntu focal cloud-img.
- `ubuntu_2004_minimal/`: packer directory for building ubuntu focal minimal cloud-img.
- `debian_11_generic/`: packer directory for building debian bullseye cloud image.
- `debian_11_genericcloud/`: packer directory for building debian bullseye smaller cloud image.
- `common-pkr/`: common code for the previous dirs.
- `ansible/`: ansible's playbooks used for the previous packer projects.
- `TODO`: possible and certain next steps.
