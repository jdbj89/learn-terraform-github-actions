variable "region" {}

/*variable "access_key" {
  description = "access_key_hw"
  type        = string
  sensitive   = true
}
variable "secret_key" {
  description = "secret_key_hw"
  type        = string
  sensitive   = true
}*/

## Network variables ##

variable "vpc" {
  type        = map(map(any))
  default     = {
  }
}

#variable "vpc_cidr" {} #"10.10.0.0/16"

variable "subnets" {
  type        = map(map(any))
  default     = {
  }
}

variable "sg_name1" {}

variable "sg_ingress_rules1" {
    type        = map(map(any))
    default     = {
    }
}
/*
variable "sg_name2" {}

variable "sg_ingress_rules2" {
    type        = map(map(any))
    default     = {
    }
}*/

variable "ecs_instances" {
    type        = map(map(any))
    default     = {
    }
}

variable "ecs_tags"{
    default = {
    }
}
