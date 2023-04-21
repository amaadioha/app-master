provider "aws" {
  region = "us-west-2"
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = "my-project"
  region  = "us-central1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

resource "azurerm_virtual_machine" "example" {
  name                  = "example-vm"
  location              = "westus2"
  resource_group_name   = "example-resource-group"
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_B1ls"
}

resource "google_compute_instance" "example" {
  name         = "example-vm"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = "westus2"
  resource_group_name = "example-resource-group"

  ip_configuration {
    name                          = "example-ip-config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = "example-resource-group"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "westus2"
  resource_group_name = "example-resource-group"
}
