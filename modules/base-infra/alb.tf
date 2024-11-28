
##################################################################
# Application Load Balancer
##################################################################
locals {
  load_balancer_name = "${var.environment}-alb"
  load_balancer_type = "application"
  https_port         = 443
  http_port          = 80
  http_protocol      = "HTTP"
  https_protocol     = "HTTPS"
  crt_domain         = "*.${var.domain_name}"
  instance_target    = "instance"
}



module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.0"

  name = local.load_balancer_name

  load_balancer_type = local.load_balancer_type

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_sg.security_group_id]

  https_listeners = [
    {
      port               = local.http_port
      protocol           = local.http_protocol
      certificate_arn    = module.acm[local.crt_domain].acm_certificate_arn
      target_group_index = 0
    }
  ]
  http_tcp_listeners = [
    {
      port        = local.http_port
      protocol    = local.http_protocol
      action_type = "redirect"
      redirect = {
        port        = local.https_port
        protocol    = local.https_protocol
        status_code = "HTTP_301"
      }
    }
  ]

  target_groups = [
    {
      name_prefix      = "https"
      backend_protocol = local.https_protocol
      backend_port     = 9443
      target_type      = local.instance_target
      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200-499"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTPS"
        timeout             = 5
        unhealthy_threshold = 2
      }
    }
  ]

  tags       = local.tags
  depends_on = [module.acm]
}

