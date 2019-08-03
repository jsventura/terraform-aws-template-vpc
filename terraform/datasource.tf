# mapeo de zonas de disponibilidad
data "aws_availability_zones" "this" {
    state = "available"
}

# estableciendo zonas de disponibilidad
locals {
  aws_availability_zones = "${slice(data.aws_availability_zones.this.names, 0, length(var.cidr_pub))}"
  zone_ids = "${slice(data.aws_availability_zones.this.zone_ids, 0, length(var.cidr_pub))}"
}