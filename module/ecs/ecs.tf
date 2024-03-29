# ecs.tf

resource "aws_ecs_cluster" "main" {
  name = "myapp-cluster"
}

data "template_file" "myapp" {
  template = file("./templates/ecs/myapp.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "myapp-task"
  execution_role_arn       = var.ecs_task_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.myapp.rendered
}

resource "aws_ecs_service" "main" {
  name            = "myapp-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.ecs_security_group_id]
    subnets          = var.pvt_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.aws_alb_target_group_id
    container_name   = "myapp"
    container_port   = var.app_port
  }

  depends_on = [var.alb_listners_frontend, var.iam_role_attachment]
}