provider "azurerm" {
  features = {}
}

resource "azurerm_resource_group" "aks_monitoring" {
  name     = "aks-monitoring-rg"
  location = "East US"  # Ganti sesuai dengan lokasi yang diinginkan
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks_monitoring.location
  resource_group_name = azurerm_resource_group.aks_monitoring.name

  default_node_pool {
    name       = "default"
    node_count = 1
  }

  identity {
    type = "SystemAssigned"
  }
}
