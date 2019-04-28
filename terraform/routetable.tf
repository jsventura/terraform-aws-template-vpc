# tabla de ruta publica
resource "aws_route_table" "pub" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}
resource "aws_route_table_association" "pub" {
  count          = "${length(var.cidr_pub)}"
  subnet_id      = "${element(aws_subnet.pub.*.id, count.index)}"
  route_table_id = "${aws_route_table.pub.id}"
}

# tabla de ruta privada
resource "aws_route_table" "pri" {
  count  = "${length(var.cidr_pri)}"
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.this.*.id, count.index)}"
  }

  tags = {
    Name  = "${var.owner}-${var.env}"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}
resource "aws_route_table_association" "pri" {
  count          = "${length(var.cidr_pri)}"
  subnet_id      = "${element(aws_subnet.pri.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.pri.*.id, count.index)}"
}