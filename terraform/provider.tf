terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }

  required_version = "~> 1.2"
}

provider "aws" {
  region = "ap-northeast-1"
}