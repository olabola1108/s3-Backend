provider "aws" {
  region = "us-east-2"
}

data "aws_instance" "demo" {

}

output "instance" {
  value = data.aws_instance.demo.arn
}