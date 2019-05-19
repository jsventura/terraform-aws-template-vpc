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