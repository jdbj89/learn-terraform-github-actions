### Provider Huawei Cloud ##

terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.74.0"
    }
  }
}

### Create VPC ###
resource "huaweicloud_vpc" "vpc" {
  region         = "${var.region}"
  name           = "${var.vpc_name}"
  cidr           = "${var.vpc_cidr}"
  tags           = "${var.tags}"
}
