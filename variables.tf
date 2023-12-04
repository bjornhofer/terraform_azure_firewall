// Base Information
variable "firewall_name_suffix" {
  description = "Suffix to be applied to the firewall base name"
  type        = string
  default     = ""
}

variable "firewall_name_prefix" {
  description = "Prefix to be applied to the firewall base name"
  type        = string
  default     = ""
}

variable "firewall_resource_group_name" {
  type        = string
  description = "resource group for the Azure Firewall"
}

variable "firewall_location" {
  description = "Location of the firewall"
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
  default     = {}
}

// Firewall settings
variable "firewall_sku_name" {
  type        = string
  description = "SKU of the Azure Firewall"
  default     = "AZFW_VNet"
}

variable "firewall_sku_tier" {
  type        = string
  description = "Tier of the Azure Firewall"
  default     = "Standard"

}

variable "firewall_virtual_network_id" {
  type        = string
  description = "Name of the virtual network for the Azure Firewall"
}

variable "firewall_subnet_id" {
  type        = string
  description = "ID of the subnet for the Azure Firewall"
}

// Public IP settings
variable "firewall_public_ip_sku" {
  type        = string
  description = "SKU of the public IP address for the Azure Firewall"
  default     = "Standard"
}

