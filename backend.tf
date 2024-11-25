terraform {
  backend "s3" {
    bucket = "my-athena-bucket-2024"
    key    = "terraform/state.tfstate"
    region = "ca-central-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }
}