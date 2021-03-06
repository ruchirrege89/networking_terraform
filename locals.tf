locals {
  vpc_name = "${terraform.workspace == dev ? terraformvpc-dev : terraformvpc-prod}"
}

resource "aws_vpc" "my_terraform_vpc" {
  #count = 10 ## loops 10 times
  count            = "${terraform.workspace == "dev" ? 0 : 1}" ## conditional based on workspace
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name        = "TerraformVPC"
    Environment = "${terraform.workspace}"
    Location    = "USA"
  }
}
