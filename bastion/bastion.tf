provider "azurerm"{
    version = "=2.20.0"
    features{}
}
resource "azurerm_resource_group" "bastion_rg" {
    name = var.bastion_rg
    location = var.location
}
resource "azurerm_public_ip" "bastion_pip"{
    name = "bastion_ip" 
    location = var.location
    resource_group_name = azurerm_resource_group.bastion_rg.name
    allocation_method = "Static"
    sku = "Standard"
}
resource "azurerm_bastion_host" "bastion_host"{
    name = "bastion-host"
    resource_group_name = azurerm_resource_group.bastion_rg.name
    location = var.location   

    ip_configuration {
        name = "us2w"
        subnet_id = data.terraform_remote_state.web.outputs.bastion_host_subnet_us2w
        public_ip_address_id = azurerm_public_ip.bastion_pip.id
    }

}