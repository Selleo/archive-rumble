module "lb_javascript_express" {
  source  = "Selleo/backend/aws//modules/load-balancer"
  version = "0.2.4"

  name       = "javascript-express"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

module "ecs_cluster_javascript_express" {
  source  = "Selleo/backend/aws//modules/ecs-cluster"
  version = "0.2.4"

  name_prefix        = "rumble-01-javascript-express"
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  instance_type      = "t3.medium"
  security_groups    = [aws_security_group.ecs.id]
  key_name           = aws_key_pair.ssh.id
  loadbalancer_sg_id = module.lb_javascript_express.loadbalancer_sg_id

  autoscaling_group = {
    min_size         = 1
    max_size         = 3
    desired_capacity = 1
  }
}

module "ecs_service_javascript_express" {
  source  = "Selleo/backend/aws//modules/ecs-service"
  version = "0.2.4"

  name           = "javascript-express"
  vpc_id         = module.vpc.vpc_id
  ecs_cluster_id = module.ecs_cluster_javascript_express.ecs_cluster_id
  desired_count  = 3
  instance_role  = module.ecs_cluster_javascript_express.instance_role

  container_definition = {
    cpu_units      = 512
    mem_units      = 512
    command        = ["node", "index.js"]
    image          = "docker.pkg.github.com/selleo/rumble/01-javascript-express:latest"
    container_port = 3000
    envs           = {}
  }

  health_check_path = "/hello"
}

resource "aws_alb_listener" "http_javascript_express" {
  load_balancer_arn = module.lb_javascript_express.loadbalancer_id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.ecs_service_javascript_express.lb_target_group_id
    type             = "forward"
  }
}

output "dns_javascript_express" {
  value = module.lb_javascript_express.loadbalancer_dns_name
}
