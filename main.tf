data "azurerm_resource_group" "rg" {
  name = var.firewall_resource_group_name
}

locals {
  //base_name = ength(var.resource_group_name_suffix) > 0 ? "${var.resource_group_name_prefix}${var.resource_group_name_separator}${var.resource_group_base_name}${var.resource_group_name_separator}${var.resource_group_name_suffix}" : length(var.resource_group_name_prefix) > 0 ? "${var.resource_group_name_prefix}${var.resource_group_name_separator}${var.resource_group_base_name}" : var.resource_group_base_name
  base_name_prefixed = length(var.firewall_base_name_prefix) > 0 ? "${var.firewall_base_name_prefix}${var.firewall_base_name_separator}${var.firewall_base_name}" : var.firewall_base_name
  base_name_suffixed = length(var.firewall_base_name_suffix) > 0 ? "${var.firewall_base_name}${var.firewall_base_name_separator}${var.firewall_base_name_suffix}" : var.firewall_base_name

  base_name = var.firewall_base_name_prefix == "" && var.firewall_base_name_suffix == "" ? var.firewall_base_name : length(var.firewall_base_name_suffix) > 0 && length(var.firewall_base_name_prefix) > 0 ? "${local.base_name_prefixed}${var.firewall_base_name_separator}${var.firewall_base_name}${var.firewall_base_name_separator}${var.firewall_base_name_suffix}" : length(var.firewall_base_name_prefix) > 0 ? local.base_name_prefixed : local.base_name_suffixed
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "${local.base_name}-pip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.firewall_location != "" ? var.firewall_location : data.azurerm_resource_group.rg.location
  sku                 = var.firewall_public_ip_sku
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_firewall" "firewall" {
  name                = local.base_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.firewall_location != "" ? var.firewall_location : data.azurerm_resource_group.rg.location
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier
  ip_configuration {
    name                 = "FirewallIPConfig"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
  tags = var.tags
}