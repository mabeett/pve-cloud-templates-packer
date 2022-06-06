packer {
  required_plugins {
    happycloud = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}
