module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "rumble-01"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "rumble-01"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_security_group" "ecs" {
  name        = "rumble-01"
  description = "Default for rumble-01"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Terraform = "true"
  }
}

resource "aws_security_group_rule" "allow_ssh_access" {
  security_group_id = aws_security_group.ecs.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
