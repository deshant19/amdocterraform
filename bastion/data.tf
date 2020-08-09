data "terraform_remote_state" "web" {
backend = "azurerm"
        config  = {
      resource_group_name = "remote-state"
      storage_account_name = "gopalterraform"
      container_name = "tfstate"
      key = "web.terraform.tfstate"
    }
}