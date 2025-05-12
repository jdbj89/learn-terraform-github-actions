terraform {
  backend "s3" {

    access_key = "QYOM9ALLBOMYEMBBKMZE"   #You can assign this value with AWS_ACCESS_KEY_ID environment variable// #export AWS_ACCESS_KEY_ID="your accesskey"
    secret_key = "lnAwd4J66L1V6M7FrhZTWI7kWaoIwpFDQhM8O0vg" #You can assign this value with AWS_SECRET_ACCESS_KEY environment variable// #export AWS_SECRET_ACCESS_KEY="your secretkey"
    bucket    = "terraform-state-test01"
    key       = "terraform.tfstate"
    region    = "la-north-2"
    endpoints = {
      s3 = "https://obs.la-north-2.myhuaweicloud.com"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}