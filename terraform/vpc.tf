# virtual private cloud
resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}

# internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}

# elastic ip addresses
resource "aws_eip" "this" {
  count   = "${length(var.cidr_pub)}"
  vpc     = true

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}

# nat gateway
resource "aws_nat_gateway" "this" {
  count         = "${length(var.cidr_pub)}"
  allocation_id = "${element(aws_eip.this.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.pub.*.id, count.index)}"

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}