terraform {
  backend "s3" {
    bucket         = "ta-terraform-tfstates-727250514989"
    key            = "labs/ASG_and_ELB/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}