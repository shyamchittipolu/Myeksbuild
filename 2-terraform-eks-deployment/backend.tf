terraform {
  backend "s3" {
    bucket = "jenkins-app-kub-2024-v2-5"
    region = "eu-west-3"
    key = "eks/terraform.tfstate"
  }
}