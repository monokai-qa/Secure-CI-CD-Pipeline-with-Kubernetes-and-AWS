terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "monokai-s3-bucket" // S3 bucket created by me
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}
