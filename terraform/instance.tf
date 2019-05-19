resource "aws_security_group" "this" {
  count       = "${var.nat_type == "server" ? 1 : 0}"
  name_prefix = "${var.owner}-${var.env}"
  description = "virtual firewall that controls the traffic"
  vpc_id      = "${aws_vpc.this.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle  {
    create_before_destroy = true
  }
}

resource "aws_instance" "this" {
  count                  = "${var.nat_type == "server" ? 1 : 0}"
  ami                    = "${data.aws_ami.this.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${element(aws_subnet.pub.*.id, 1)}"
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  key_name               = "${var.owner}-${var.env}"
  source_dest_check      = false

  tags = {
    Name  = "${var.owner}-${var.env}-nat"
    Owner = "${var.owner}"
    Env   = "${var.env}"
  }
}