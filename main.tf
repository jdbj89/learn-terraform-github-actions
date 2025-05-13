module "vpc" {
  for_each            = var.vpc
  source              = "./modules/vpc"
  region              = var.region
  vpc_name            = each.value.vpc_name
  vpc_cidr            = each.value.cidr
}

module "subnet" {
  for_each            = var.subnets
  source              = "./modules/subnet"
  depends_on          = [module.vpc]
  region              = var.region
  subnet              = each.value.subnet_name
  cidr                = each.value.cidr
  gateway_ip          = each.value.gateway_ip
  vpc_name            = each.value.vpc_name
}

module "sg1" {
  source              = "./modules/sg"
  region              = var.region
  sg_name             = var.sg_name1
  sg_ingress_rules    = var.sg_ingress_rules1
}

module "ecs" {
  for_each          = var.ecs_instances
  source              = "./modules/ecs"
  depends_on          = [module.vpc, module.subnet, module.sg1]
  region              = var.region
  ecs_name            = each.value.name
  ecs_password        = each.value.pass
  availability_zone   = each.value.az
  subnet_name         = each.value.subnet
  sg_name             = each.value.sg
  ecs_image_name      = each.value.image
  ecs_image_type      = each.value.itype
  ecs_generation      = each.value.gen
  cpu_core_count      = each.value.cpu
  memory_size         = each.value.mem
  ecs_sysdisk_type    = each.value.sdtype
  ecs_sysdisk_size    = each.value.sdsize
  ecs_datadisk_number = each.value.ddnum
  ecs_datadisk_type   = each.value.ddtype
  ecs_datadisk_size   = each.value.ddsyze
  ecs_attach_eip      = each.value.eip
  eip_bandwidth_size  = each.value.banw_size
  ecs_tags            = var.ecs_tags
}
