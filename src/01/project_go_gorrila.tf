module "lb_go_gorilla" {
  source  = "Selleo/backend/aws//modules/load-balancer"
  version = "0.2.3"

  name       = "go-gorilla"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

module "ecs_cluster_go_gorilla" {
  source  = "Selleo/backend/aws//modules/ecs-cluster"
  version = "0.2.3"

  name_prefix        = "rumble-01-go-gorilla"
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  instance_type      = "t3.medium"
  security_groups    = [aws_security_group.ecs.id]
  key_name           = aws_key_pair.ssh.id
  loadbalancer_sg_id = module.lb_go_gorilla.loadbalancer_sg_id

  autoscaling_group = {
    min_size         = 1
    max_size         = 3
    desired_capacity = 1
  }
}

module "ecs_service_go_gorilla" {
  source  = "Selleo/backend/aws//modules/ecs-service"
  version = "0.2.3"

  name           = "go-gorilla"
  vpc_id         = module.vpc.vpc_id
  ecs_cluster_id = module.ecs_cluster_go_gorilla.ecs_cluster_id
  desired_count  = 3
  instance_role  = module.ecs_cluster_go_gorilla.instance_role

  container_definition = {
    cpu_units      = 512
    mem_units      = 512
    command        = ["/app/web"]
    image          = "docker.pkg.github.com/selleo/rumble/01-go-gorilla:latest"
    container_port = 3000
    envs           = {}
  }

  health_check_path = "/hello"
}

resource "aws_alb_listener" "http_go_gorilla" {
  load_balancer_arn = module.lb_go_gorilla.loadbalancer_id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.ecs_service_go_gorilla.lb_target_group_id
    type             = "forward"
  }
}

output "dns_go_gorilla" {
  value = module.lb_go_gorilla.loadbalancer_dns_name
}
