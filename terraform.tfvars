region = "la-north-2"
#access_key = "QYOM9ALLBOMYEMBBKMZE"   #You can assign this value with AWS_ACCESS_KEY_ID environment variable// #export AWS_ACCESS_KEY_ID="your accesskey"
#secret_key = "lnAwd4J66L1V6M7FrhZTWI7kWaoIwpFDQhM8O0vg" #You can assign this value with AWS_SECRET_ACCESS_KEY environment variable// #export AWS_SECRET_ACCESS_KEY="your secretkey"
## Network variables ##

vpc = {
        vpc1 = {vpc_name="vpc_tf", cidr="172.16.0.0/12"}
}

subnets = {
        subnet1 = {vpc_name="vpc_tf", subnet_name="subnet-tf-dev", cidr="172.16.1.0/24", gateway_ip="172.16.1.1"}
}

sg_name1 = "sg-tf-dev"

sg_ingress_rules1 = {
        rule1 = {port=22, proto="tcp", cidr="0.0.0.0/0", desc="SSH Remotely Login from Internet for Linux"}
        rule2 = {port=3389, proto="tcp", cidr="0.0.0.0/0", desc="RDP Remotely Login from Internet for Windows"}
        rule3 = {port=80, proto="tcp", cidr="0.0.0.0/0", desc="Access Webserver HTTP from Internet"}
        rule4 = {port=443, proto="tcp", cidr="0.0.0.0/0", desc="Access Webserver HTTPs from Internet"}
        rule5 = {port="", proto="icmp", cidr="0.0.0.0/0", desc="Allows external servers to ping the instances in the security group to verify network connectivity."}
        rule6 = {port=3306, proto="tcp", cidr="0.0.0.0/0", desc="Allows communication with MySQL database."}
}

ecs_instances = {
        ecs1 = {name= "ecs-tf-01", pass="ecs.centos.01", az="la-north-2a", subnet="subnet-tf-dev", sg="sg-tf-dev", image="CentOS 7.6 64bit", itype="public", gen="c6", cpu="2", mem="4", sdtype="SAS", sdsize="40", ddnum="0", ddtype="", ddsyze="", eip=false, banw_size=""}
}