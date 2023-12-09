provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

data "aws_instance" "demo" {

}

output "instance" {
  value = data.aws_instance.demo.arn
}