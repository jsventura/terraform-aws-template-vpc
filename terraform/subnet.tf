# subnet publica
resource "aws_subnet" "pub" {
  count                   = "${length(var.cidr_pub)}"
  vpc_id                  = "${aws_vpc.this.id}"
  cidr_block              = "${element(var.cidr_pub, count.index)}"
  availability_zone       = "${element(local.aws_availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.owner}-${var.env}-pub-${element(local.zone_ids, count.index)}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
    Tier  = "pub"
    az    = "${element(local.zone_ids, count.index)}"
  }
}

# subnet privada
resource "aws_subnet" "pri" {
  count                   = "${length(var.cidr_pri)}"
  vpc_id                  = "${aws_vpc.this.id}"
  cidr_block              = "${element(var.cidr_pri, count.index)}"
  availability_zone       = "${element(local.aws_availability_zones, count.index)}"
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.owner}-${var.env}-pri-${element(local.zone_ids, count.index)}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
    Tier  = "pri"
    az    = "${element(local.zone_ids, count.index)}"
  }
}