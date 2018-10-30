provider "aws" {
  shared_credentials_file = "/home/centos/.aws/credentials"
  region = "${var.region}"
  profile = "default"
  skip_region_validation = true
}

resource "aws_security_group" "ForBalancer" {
  name 		= "For_Balancer"
  description 	= "A Security group that will apply to the balancer"
  vpc_id 	= "${var.myvpcid}"

  #Allowing http from anywhere

  ingress {
    from_port 	= 80
    to_port 	= 80
    protocol 	= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


module "balancer1" {
  source 	= "../tf-module"
  modname 	= "Balancer1"
  SecGroupId 	= "${aws_security_group.ForBalancer.id}"
}


