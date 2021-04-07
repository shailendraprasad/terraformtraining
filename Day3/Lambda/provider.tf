provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket ="nsp-tfstate-2021"
    key = "lambda/tfstate"
    region = "us-east-1"
  }
}