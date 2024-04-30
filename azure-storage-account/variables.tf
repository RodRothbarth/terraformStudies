variable "azure_location" {
  type    = string
  default = "Brazil South"
}

variable "azure_account_tier" {
  type    = string
  default = "Standard"
}

variable "azure_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "resource_group_name" {
  type    = string
  default = "RG_terraform"
}

variable "storage_account_name" {
  type    = string
  default = "rodrothbarthterraform"
}

variable "container" {
  type    = string
  default = "rothbarthcontainerterraform"
}
