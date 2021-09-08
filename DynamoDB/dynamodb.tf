terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}



resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "nCodeIT"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "CandidateId"
  range_key      = "Company"

  attribute {
    name = "CandidateId"
    type = "S"
  }

  attribute {
    name = "Company"
    type = "S"
  }

  attribute {
    name = "Salary"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "nCodeIndex"
    hash_key           = "Company"
    range_key          = "Salary"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["CandidateId"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
