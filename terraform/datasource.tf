# mapeo de zonas de disponibilidad
data "aws_availability_zones" "this" {
    state = "available"
}

# estableciendo zonas de disponibilidad
locals {
  aws_availability_zones = "${slice(data.aws_availability_zones.this.names, 0, 3)}"
  zone_ids = "${slice(data.aws_availability_zones.this.zone_ids, 0, 3)}"
}


# capturar id de ami
data "aws_ami" "this" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-hvm-2018.03.*-x86_64-ebs",]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989", "591542846629", "801119661308", "102837901569", "013907871322", "206029621532", "286198878708", "443319210888"]
}