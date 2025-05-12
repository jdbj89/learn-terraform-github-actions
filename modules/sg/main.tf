### Provider Huawei Cloud ##

terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.74.0"
    }
  }
}

## Security Group Resource ##
resource "huaweicloud_networking_secgroup" "securitygroup" {
  region               = "${var.region}"
  name                 = "${var.sg_name}"
  delete_default_rules = false
}

## Security Group Rule INGRESS Resource ##
resource "huaweicloud_networking_secgroup_rule" "allow_rules_ingress_main" {
  for_each          = "${var.sg_ingress_rules}"
  region            = "${var.region}"
  direction         = "ingress"
  ethertype         = "IPv4"
  ports             = each.value.port
  protocol          = each.value.proto
  remote_ip_prefix  = each.value.cidr
  description       = each.value.desc
  security_group_id = "${huaweicloud_networking_secgroup.securitygroup.id}"
}

## Security Group Rule EGRESS Resource ##
resource "huaweicloud_networking_secgroup_rule" "allow_rules_egress" {
  region            = "${var.region}"
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${huaweicloud_networking_secgroup.securitygroup.id}"
}