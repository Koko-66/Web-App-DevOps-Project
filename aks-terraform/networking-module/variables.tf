variable "resource_group_name" {
    description = "The name of the resource group for the project"
    type = string
    default = "networking-rg"
}

variable "location" {
    description = "The Azure region where the resources will be deployed"
    type = string
    default = "UK South"
}

variable "vnet_address_space" {
    description = "The address space used the virtual network"
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "source_ip" {
    description = "The source IP address for use in the network security rule"
    type = string
    sensitive = true
}