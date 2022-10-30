variable "location" {
  description = "Location/Region where resources should be deployed | Mandatory"
}

variable "rg_name" {
  description = "Resource Group name"
  default     = "rg-this"
}

variable "vnet_name" {
  description = "vNet name"
  default     = "vnet-this"
}

variable "sg_name" {
  description = "Security Group Name for Internet interface"
  default     = "sg-inetv4-subnet"
}

variable "inet_subnet_name" {
  description = "Security Group Name for Internet interface"
  default     = "inetv4-subnet"
}

variable "tags" {
  description = "A map of ngena tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cidr" {
  description = "CIDR Block for vNet"
  type        = list(string)
  default     = ["192.168.0.0/16"]
}

variable "cidr_subnet" {
  description = "CIDR for inetv4 Subnet"
  type        = list(string)
  default     = ["192.168.0.0/24"]
}

variable "vm_count" {
  description = "VM Count"
  default     = 0
}

variable "public_ip" {
  description = "VM Count"
  type        = bool
  default     = false
}

# VM variables
variable "vm_username" {
  description = "Username for Virtual Machines"
  type        = string
  default     = "vmadmin"
}

variable "vm_password" {
  description = "Password for Virtual Machines"
  type        = string
}

variable "vm_size" {
  description = "Size of the VMs"
  type        = string
  default     = "Standard_B1s"
}
