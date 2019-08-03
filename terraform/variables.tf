variable "owner" {}
variable "env" {}
variable "cidr_block" {}
variable "cidr_pub" {
    type = "list"
}
variable "cidr_pri" {
    type = "list"
}