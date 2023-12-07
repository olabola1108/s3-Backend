variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["172.32.1.0/24", "172.32.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["172.32.4.0/24", "172.32.5.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-2a", "us-east-2b"]
}

variable "private_subnet_names" {
  type    = list(string)
  default = ["Private_subnet1", "Private_subnet2"]
}

variable "public_subnet_names" {
  type    = list(string)
  default = ["Public_subnet1", "Public_subnet2"]
}