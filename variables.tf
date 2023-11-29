// Base Information
variable "base_name" {
  description = "Base name for all resources"
  type = string
}

variable "firewall_resource_group_name" {
  type        = string
  description = "resource group for the Azure Firewall"
}

variable "firewall_location" {
  description = "Location of the firewall"
  type = string
  default = ""
}
