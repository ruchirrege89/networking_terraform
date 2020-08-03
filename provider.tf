## Passing aws setup inputs. the enironment keys are used
provider "aws" {
  region = "${var.region}"
}

## Remotely saving terraform statefile in S3
terraform {
  backend "s3" {
    bucket         = "XXXXX-bucket" ## Replace with the actual bucket name
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraformlock"
  }

}


# output "vpc_cidr" {
#   value = "${aws_vpc.my_terraform_vpc.cidr_block}"
# }
