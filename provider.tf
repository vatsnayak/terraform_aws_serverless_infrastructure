terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0" # Use this to allow any version above 5.0.0
    }
  }
}

provider "aws" {
  region = var.aws_region # or specify your AWS region here
}
