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