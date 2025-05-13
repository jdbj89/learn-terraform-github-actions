terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.74.0"
    }
  }
}
provider "huaweicloud" {
  region     = var.region
  #access_key = var.access_key    # Not necessaty if you configure the env vars
  #secret_key = var.secret_key    # Not necessaty if you configure the env vars
}