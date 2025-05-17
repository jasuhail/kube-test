terraform {
  backend "s3" {
    bucket = "jasland-state-file"
    region = "eu-west-1"
    key = "eks/terraform.tfstate"
    dynamodb_table = "jenkins-terraform-s3"
  }
}
