terraform {
  backend "remote" {
    organization = "stevethomas01"

    workspaces {
      name = "development"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.66.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "st15977-867089037134" {
  bucket = "st15977-867089037134"
  acl    = "private"

    lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = "log/"

    tags = {
      rule      = "log"
      autoclean = "true"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  lifecycle_rule {
    id      = "tmp"
    prefix  = "tmp/"
    enabled = true

    expiration {
      date = "2021-11-27"
    }
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}