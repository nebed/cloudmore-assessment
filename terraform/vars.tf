variable "prefix" {
  default = "monitor-temp"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "location" {
  default = "Central US"
}

variable "internal_subnet_prefix" {
  default = ["10.0.2.0/24"]
}

variable "external_subnet_prefix" {
  default = ["10.0.3.0/24"]
}

variable "vm_type" {
  default = "Standard_D2as_v5"
}

variable "vm_username" {
  default = "cloudmoreadmin"
}

variable "last_state" {
  type    = string
  default = null
}

variable "playbook" {
  default = "main.yml"
}