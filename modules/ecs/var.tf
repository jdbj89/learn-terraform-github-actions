## Region and Availability zone variables ##

variable "region" {
}

variable "availability_zone" {
}

## Network variables ##

variable "subnet_name" {
}

variable "sg_name" {
}

### ECS variables ###

variable "ecs_name" {
}

variable "ecs_generation" {
}

variable "cpu_core_count" {
}

variable "memory_size" {
}

variable "ecs_image_name" {
}

variable "ecs_image_type" {
}

variable "ecs_sysdisk_type" {
}

variable "ecs_sysdisk_size" {
}

variable "ecs_datadisk_number" {
}

variable "ecs_datadisk_type" {
}

variable "ecs_datadisk_size" {
}

variable "ecs_password"{
    
}

variable "ecs_tags"{
    default = {
    }
}

### ECS Elastic IP variables ###

variable "ecs_attach_eip" {
}

variable "eip_bandwidth_size" {
}
