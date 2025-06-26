terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 0.13"
}

variable "token_timeweb" {}
variable "ssh_key" {}
variable "preset_ids" {}
variable "project_ids" {}

provider "twc" {
  token = var.token_timeweb
}

resource "twc_floating_ip" "Lune_prod-floating-ip" {
  availability_zone = "msk-1"
  ddos_guard        = false
}

resource "twc_server" "Lune_prod" {
  name                      = "Lune_prod"
  preset_id                 = var.preset_ids
  project_id                = var.project_ids
  os_id                     = 91
  availability_zone         = "msk-1"
  is_root_password_required = false
  ssh_keys_ids              = var.ssh_key
  floating_ip_id            = twc_floating_ip.Lune_prod-floating-ip.id
}
