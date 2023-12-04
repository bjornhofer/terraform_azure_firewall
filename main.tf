data "azurerm_resource_group" "rg" {
  name = var.firewall_resource_group_name
}

module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = [ "${var.firewall_name_suffix}" ]
  prefix = [ "${var.firewall_name_prefix}" ]
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = module.naming.public_ip
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.firewall_location != "" ? var.firewall_location : data.azurerm_resource_group.rg.location
  sku                 = var.firewall_public_ip_sku
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_firewall" "firewall" {
  name                = module.naming.firewall
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
