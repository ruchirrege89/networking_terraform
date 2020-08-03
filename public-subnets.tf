locals {
  az_names    = "${data.aws_availability_zones.azs.names}"
  pub_sub_ids = "${aws_subnet.public.*.id}"
}

resource "aws_subnet" "public" {
  count             = "${length(slice(local.az_names, 0, 2))}"      ### Loop based on the count of availability zones
  vpc_id            = "${aws_vpc.my_terraform_vpc.id}"              ### get vpc id
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index)}" ### generate non-overlapping cidr blocks for subnets
  availability_zone = "${local.az_names[count.index]}"              ### extract availability zones
  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_terraform_vpc.id}" ### get vpc id

  tags = {
    Name = "RuchirIGW"
  }
}

resource "aws_route_table" "prt" {
  vpc_id = "${aws_vpc.my_terraform_vpc.id}" ### get vpc id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"

    tags = {
      Name = "RuchirPRT"
    }
  }
}

resource "aws_route_table_association" "pub_sub_association" {
  count          = "${length(slice(local.az_names, 0, 2))}"
  subnet_id      = "${local.pub_sub_ids[count.index]}"
  route_table_id = "${aws_route_table.prt.id}"

}
