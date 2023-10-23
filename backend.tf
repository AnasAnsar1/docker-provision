terraform {
  backend "s3" {
    bucket = "terraformbackendo7"
    key = "provdeploydev"
    region = "ap-south-1"
    dynamodb_table = "terraformbackendo7"
  }
}