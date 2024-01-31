variable "aks_cluster_name" {
    description = "The name of the AKS cluster"
    type        = string
} 
variable "cluster_location" {
    description = "The Azure region where the AKS cluster will be deployed to"
    type        = string
}

variable "dns_prefix" {
    description = "The DNS prefix specified when creating the AKS cluster"
    type        = string
}

variable "kubernetes_version" {
    description = "The version of Kubernetes to use for the AKS cluster"
    type        = string
}

variable "service_principal_client_id" {
    description = "The Client ID for the service principal associated with the cluster"
    type        = string
}

variable "service_principal_secret" {
    description = "The Client Secret for the service principal"
    type        = string
}

variable "resource_group_name"{
    description = "The name of the resource group in which to create the AKS cluster"
    type        = string
}

variable "vnet_id" {
    description = "The ID of the VNet in which to create the AKS cluster"
    type        = string
}

variable "control_plane_subnet_id" {
    description = "The ID of the subnet in which to create the AKS cluster control plane"
    type        = string
}

variable "worker_node_subnet_id" {
    description = "The ID of the subnet in which to create the AKS cluster worker nodes"
    type        = string
}


