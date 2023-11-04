packer {
  required_plugins {
    happycloud = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}
