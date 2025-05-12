### Provider Huawei Cloud ##

terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.74.0"
    }
  }
}

data "huaweicloud_vpc" "vpc" {
  name = var.vpc_name
}

### Create subnet ###
resource "huaweicloud_vpc_subnet" "subnet" {
  region        = var.region
  name          = var.subnet
  cidr          = var.cidr
  gateway_ip    = var.gateway_ip
  vpc_id        = data.huaweicloud_vpc.vpc.id
}