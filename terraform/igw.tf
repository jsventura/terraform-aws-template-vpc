# internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}