resource "aws_dynamodb_table" "dynamo-lock" {
  name           = var.table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  tags = {
    Name = "S3-lock"
  }


  attribute {
    name = "LockID"
    type = "S"
  }
}