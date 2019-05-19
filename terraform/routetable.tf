# tabla de ruta publica
resource "aws_route_table" "pub" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = {
    Name  = "${var.owner}-${var.env}-pub"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}
resource "aws_route_table_association" "pub" {
  count          = "${length(var.cidr_pub)}"
  subnet_id      = "${element(aws_subnet.pub.*.id, count.index)}"
  route_table_id = "${aws_route_table.pub.id}"
}


# tabla de ruta privada (server)
resource "aws_route_table" "server" {
  count  = "${var.nat_type == "server" ? 1 : 0}"
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.this.id}"
  }

  tags = {
    Name  = "${var.owner}-${var.env}-pri"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}
resource "aws_route_table_association" "server" {
  count          = "${var.nat_type == "server" ? length(var.cidr_pri) : 0}"
  subnet_id      = "${element(aws_subnet.pri.*.id, count.index)}"
  route_table_id = "${aws_route_table.server.id}"
}


# tabla de ruta privada (service)
resource "aws_route_table" "service" {
  count  = "${var.nat_type == "service" ? length(var.cidr_pri) : 0}"
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.this.*.id, count.index)}"
  }

  tags = {
    Name  = "${var.owner}-${var.env}-pri"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}
resource "aws_route_table_association" "service" {
  count          = "${var.nat_type == "service" ? length(var.cidr_pri) : 0}"
  subnet_id      = "${element(aws_subnet.pri.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.service.*.id, count.index)}"
}