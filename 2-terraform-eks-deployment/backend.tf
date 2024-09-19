terraform {
  backend "s3" {
    bucket = "jasuuk-state-file"
    region = "eu-west-1"
    key = "eks/terraform.tfstate"
  }
}