provider "helm" {
  kubernetes {
    config_path = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_key
    host        = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
    token       = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].token
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "monitoring"

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "default"
  }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "default"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"

  set {
    name  = "adminPassword"
    value = "your_grafana_password"
  }
}
