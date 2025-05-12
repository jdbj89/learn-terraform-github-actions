### Provider Huawei Cloud ## 

terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.74.0"
    }
  }
}

data "huaweicloud_vpc_subnet" "subnet" {
  name        = "${var.subnet_name}"
}

data "huaweicloud_networking_secgroup" "securitygroup" {
  name        = "${var.sg_name}"
}

data "huaweicloud_images_image" "ecs_image" {
  name        = "${var.ecs_image_name}"
  visibility  = "${var.ecs_image_type}"
  most_recent = true
}

data "huaweicloud_compute_flavors" "flavors" {
  availability_zone = "${var.availability_zone}"
  generation        = "${var.ecs_generation}"
  cpu_core_count    = "${var.cpu_core_count}"
  memory_size       = "${var.memory_size}"
}

## ECS Resource ## 
resource "huaweicloud_compute_instance" "ecs_generic_instance" {
  name                        = "${var.ecs_name}"
  charging_mode               = "postPaid"
  image_id                    = "${data.huaweicloud_images_image.ecs_image.id}"
  availability_zone           = "${var.availability_zone}"
  flavor_id                   = "${data.huaweicloud_compute_flavors.flavors.ids[0]}"
  system_disk_type            = "${var.ecs_sysdisk_type}"
  system_disk_size            = "${var.ecs_sysdisk_size}"
  delete_disks_on_termination = true
  admin_pass                  = "${var.ecs_password}"
  tags                        = "${var.ecs_tags}"

  network {
    uuid                      = "${data.huaweicloud_vpc_subnet.subnet.id}"
  }
  security_group_ids = [
    "${data.huaweicloud_networking_secgroup.securitygroup.id}"
  ]
}

## ECS - Data Disk ##
resource "huaweicloud_evs_volume" "datadisk" {
  count             = "${var.ecs_datadisk_number}"
  name              = "${var.ecs_name}-datadisk${count.index}"
  availability_zone = "${var.availability_zone}"
  volume_type       = "${var.ecs_datadisk_type}"
  size              = "${var.ecs_datadisk_size}"
}

## ECS - Attach Data Disk ##
resource "huaweicloud_compute_volume_attach" "attached" {
  count       = "${var.ecs_datadisk_number}"
  instance_id = "${huaweicloud_compute_instance.ecs_generic_instance.id}"
  volume_id   = "${huaweicloud_evs_volume.datadisk[count.index].id}"
}


## ECS - Elastic IP Resource ##
resource "huaweicloud_vpc_eip" "instance_eip" {
  count          = "${var.ecs_attach_eip ? 1 : 0}"

  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "${var.ecs_name}-bandwidth"
    size        = "${var.eip_bandwidth_size}"
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

### ECS - Elastic IP Associate Resource ##
resource "huaweicloud_vpc_eip_associate" "associated" {
  count       = "${var.ecs_attach_eip ? 1 : 0}"
  public_ip   = "${element(huaweicloud_vpc_eip.instance_eip.*.address,count.index)}"
  network_id  = "${element(huaweicloud_compute_instance.ecs_generic_instance.network[*].uuid,count.index)}"
  fixed_ip    = "${element(huaweicloud_compute_instance.ecs_generic_instance.network[*].fixed_ip_v4,count.index)}"
}