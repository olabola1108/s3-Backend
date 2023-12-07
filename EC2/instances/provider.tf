terraform {
  backend "s3" {
    bucket         = "new-dev-477"
    key            = "ec2/terraform.tfstate"
    dynamodb_table = "My-terraform-remote-state-dynamo"
    region         = "us-east-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.0"
}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../../vpc/terraform.tfstate"
  }
}
provider "aws" {
  region = var.aws_region
  #profile = "terraform"
}
