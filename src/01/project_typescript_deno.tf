module "lb_typescript_deno" {
  source  = "Selleo/backend/aws//modules/load-balancer"
  version = "0.2.4"

  name       = "typescript-deno"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

module "ecs_cluster_typescript_deno" {
  source  = "Selleo/backend/aws//modules/ecs-cluster"
  version = "0.2.4"

  name_prefix        = "rumble-01-typescript-deno"
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  instance_type      = "t3.medium"
  security_groups    = [aws_security_group.ecs.id]
  key_name           = aws_key_pair.ssh.id
  loadbalancer_sg_id = module.lb_typescript_deno.loadbalancer_sg_id

  autoscaling_group = {
    min_size         = 1
    max_size         = 3
    desired_capacity = 1
  }
}

module "ecs_service_typescript_deno" {
  source  = "Selleo/backend/aws//modules/ecs-service"
  version = "0.2.4"

  name           = "typescript-deno"
  vpc_id         = module.vpc.vpc_id
  ecs_cluster_id = module.ecs_cluster_typescript_deno.ecs_cluster_id
  desired_count  = 3
  instance_role  = module.ecs_cluster_typescript_deno.instance_role

  container_definition = {
    cpu_units      = 512
    mem_units      = 512
    command        = ["/app/web"]
    image          = "docker.pkg.github.com/selleo/rumble/01-typescript-deno:latest"
    container_port = 3000
    envs           = {}
  }

  health_check_path = "/hello"
}

resource "aws_alb_listener" "http_typescript_deno" {
  load_balancer_arn = module.lb_typescript_deno.loadbalancer_id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.ecs_service_typescript_deno.lb_target_group_id
    type             = "forward"
  }
}

output "dns_typescript_deno" {
  value = module.lb_typescript_deno.loadbalancer_dns_name
}
