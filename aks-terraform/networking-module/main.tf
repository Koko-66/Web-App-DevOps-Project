terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.0.0"
        }
    }
}

provider "azurerm" {
    features {}
}

# Create the resource group for networking resources
resource "azurerm_resource_group" "networking" {
    name = var.resource_group_name
    location = var.location
}

# Create the virtual network
resource "azurerm_virtual_network" "aks-vnet" {
    name = "aks-vnet"
    address_space = var.vnet_address_space
    location = var.location
    resource_group_name = var.resource_group_name
}

# Create control plane subnet
resource "azurerm_subnet" "control-plane-subnet" {
    name = "control-plane-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.aks-vnet.name
    address_prefixes = ["10.0.0.1.0/24"]
}

# Create worker node subnet
resource "azurerm_subnet" "worker-node-subnet" {
    name = "worker-node-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.aks-vnet.name
    address_prefixes = ["10.0.0.2.0/24"]
}

# Create the network security group
resource "azurerm_network_security_group" "aks-nsg" {
    name = "aks-nsg"
    location = var.location
    resource_group_name = var.resource_group_name
}

# Create the network security group rule for allowing traffic to kube api server
resource "azurerm_network_security_rule" "kube-apiserver-rule" {
    name = "kube-apiserver-rule"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = var.source_ip
    destination_address_prefix = "*"
    resource_group_name = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.aks-nsg.name
}   

# Create the network security group rule for allowing inbound SSH traffic
resource "azurerm_network_security_rule" "ssh-rule" {
    name = "ssh-rule"
    priority = 1002
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = var.source_ip
    destination_address_prefix = "*"
    resource_group_name = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.aks-nsg.name
}

