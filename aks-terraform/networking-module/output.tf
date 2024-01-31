output "vnet_id" {
    description = "The ID of the virtual network"
    value = azurerm_virtual_network.aks-vnet.id
}

output "control_plane_subnet_id" {
    description = "The ID of the control plane subnet"
    value = azurerm_subnet.control-plane-subnet.id
}

output "worker_node_subnet_id" {
    description = "The ID of the worker node subnet"
    value = azurerm_subnet.worker-node-subnet.id
}

output "networking_resource_group_name" {
    description = "The name of the resource group where the networking resources are created"
    value = azurerm_resource_group.networking.name
}

output "aks_nsg_id" {
    description = "The ID of the network security group for the AKS cluster"
    value = azurerm_network_security_group.aks-nsg.id
}