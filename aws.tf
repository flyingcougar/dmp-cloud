provider "aws" {}


data "aws_vpcs" "selected" {

}

output "my_vpc" {
  value = "${data.aws_vpcs.selected.ids}"
}