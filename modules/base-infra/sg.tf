##################################################################
#################ALB SECURITY GROUP###############################
##################################################################


locals {
  alb_sg_name       = "${var.environment}-alb-sg"
  rds_sg_name       = "${var.environment}-rds-sg"
  nodegroup_sg_name = "${var.environment}-nodegroup-sg"
  cidr_anyipv4      = "0.0.0.0/0"
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  description            = "Security group for public ALB"
  create                 = true
  name                   = local.alb_sg_name
  vpc_id                 = module.vpc.vpc_id
  revoke_rules_on_delete = true

  ##########
  # Ingress
  ##########
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow http traffic"
      cidr_blocks = local.cidr_anyipv4
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "allow https traffic"
      cidr_blocks = local.cidr_anyipv4
    },
    {
      from_port   = 9443
      to_port     = 9443
      protocol    = "tcp"
      description = "allow https traffic"
      cidr_blocks = local.cidr_anyipv4
    },
  ]

  #########
  # Egress
  #########
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "allow all outbound traffic"
      cidr_blocks = local.cidr_anyipv4
    },
  ]
  tags = local.tags

}
##################################################################
###########NODEGROUP SECURITY GROUP###############################
##################################################################
module "nodegroup_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  description            = "Security group for incoming traffic from ALB to nodegroups"
  create                 = true
  name                   = local.nodegroup_sg_name
  vpc_id                 = module.vpc.vpc_id
  revoke_rules_on_delete = true

  ###############
  # Ingress Rules
  ###############
  ingress_with_source_security_group_id = [
    {
      from_port                = 30477
      to_port                  = 30477
      protocol                 = "tcp"
      description              = "allow http traffic ALB"
      source_security_group_id = module.alb_sg.security_group_id
    },
    {
      from_port                = 31752
      to_port                  = 31752
      protocol                 = "tcp"
      description              = "allow https traffic from ALB"
      source_security_group_id = module.alb_sg.security_group_id
    },
  ]
  tags = local.tags

}
