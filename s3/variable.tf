variable "region" {
  type    = string
  default = "us-east-2"
}

variable "env" {
  type = string
}

variable "ver" {
  type    = string
  default = "Enabled"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "My-terraform-remote-state-dynamo"
}