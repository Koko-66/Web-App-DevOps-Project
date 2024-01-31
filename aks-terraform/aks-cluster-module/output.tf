output "aks_cluster_name" {
    description = "The name of the AKS cluster"
    value       = azurerm_kubernetes_cluster.aks-cluster.name
}

output "aks_cluster_id" {
    description = "The ID of the AKS cluster"
    value       = azurerm_kubernetes_cluster.aks-cluster.id

}

output "aks_kubeconfig" {
    description = "The Kubernetes configuration file of the AKS cluster essential for interacting with and managing the AKS cluster using kubectl"
    value       = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw

}