# nat gateway
resource "aws_nat_gateway" "this" {
  count         = "${var.nat_type == "server" ? 0 : length(var.cidr_pub)}"
  allocation_id = "${element(aws_eip.this.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.pub.*.id, count.index)}"

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}