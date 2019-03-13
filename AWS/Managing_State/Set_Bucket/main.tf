terraform {
  backend "s3" {
    bucket = "cruz3r-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}