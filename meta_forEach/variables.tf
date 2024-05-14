variable "azure-location" {
  type = map(string)
  default = {
    "brasil" = "Brazil South",
    "canada" = "Canada Central",
    "eua"    = "East Us",
    "asia"   = "Japan East"
  }
}

variable "azure_account_tier" {
  type    = string
  default = "Standard"
}

variable "azure_account_replication_type" {
  type    = string
  default = "LRS"
}
