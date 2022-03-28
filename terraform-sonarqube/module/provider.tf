provider "aws" {
  profile = "atul"
  region  = "us-west-2"
}

terraform {
  backend "s3" {
    profile = "atul"
    bucket = "mehulsharma"
    key = "tf"
    region = "us-west-2"
  }
}