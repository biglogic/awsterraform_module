module "vpc" {
  source            = "./network"
  health_check_path = var.health_check_path
  app_port          = var.app_port
  az_count          = var.az_count
}

module "sg" {
  source   = "./security"
  vpc_id   = module.vpc.vpc_id
  app_port = var.app_port
}


module "tg"{
   source = "./alb/tg"
   count = length(var.tg_name)
   tg_name =  var.tg_name[count.index]
   vpc_id            = module.vpc.vpc_id

}



module "alb" {
  source            = "./alb"
  vpc_id            = module.vpc.vpc_id
  app_port          = var.app_port
  health_check_path = var.health_check_path
  vpc_subnets       = module.vpc.subnet_ids
  tg_id             = module.tg[0].aws_alb_target_group_id
  sg_lb_id          = module.sg.sg_lb_id
  listener_rule = [
  {
    listener_arn = "ayx"
    target_group_arn = module.tg[0].aws_alb_target_group_id
    conditions = "path_pattern"
    value = ["/example"]
  },
  {
    listener_arn = "ayx"
    target_group_arn = module.tg[0].aws_alb_target_group_id
    conditions = "host_header"
    value = ["dynamodb.us-west-2.amazonaws.com"]
  }]
  # {
  #    listener_arn = "ayx"
  #    target_group_arn = "arn:aws:elasticloadbalancing:us-west-2:276264014537:targetgroup/tg3/76d3eb62ecc5049d"
  #    conditions = "host_header"
  #    value = ["dynamodb.us-west-5.amazonaws.com"]
  # }]
}

module "alb_test" {
  source            = "./alb"
  count             = 1
  vpc_id            = module.vpc.vpc_id
  app_port          = var.app_port
  health_check_path = var.health_check_path
  vpc_subnets       = module.vpc.subnet_ids
  sg_lb_id          = module.sg.sg_lb_id
  tg_id             = module.tg[count.index+1].aws_alb_target_group_id
  listener_rule = [
  {
    listener_arn = "ayx"
    target_group_arn = module.tg[count.index+1].aws_alb_target_group_id
    conditions = "host_header"
    value = ["dynamodb.us-west-5.amazonaws.com"]
  }]
}

module "role" {
  source                       = "./roles"
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
}

# module "log" {
#   source = "./logs"
# }

# module "ecs" {
#   source                  = "./ecs"
#   app_image               = var.app_image
#   app_port                = var.app_port
#   app_count               = var.app_count
#   fargate_cpu             = var.fargate_cpu
#   fargate_memory          = var.fargate_memory
#   ecs_task_role_arn       = module.role.ecs_task_role_arn
#   pvt_subnets             = module.vpc.subnet_ids
#   aws_alb_target_group_id = module.tg[0].aws_alb_target_group_id
#   ecs_security_group_id   = module.sg.aws_ecs_security_group_id
#   alb_listners_frontend   = module.alb[0].aws_alb_listene_frint_end
#   iam_role_attachment     = module.role.ecs_task_role_attachment_arn
# }

# module "asg" {
#   source           = "./asg"
#   ecs_service_name = module.ecs.ecs_service_name
#   ecs_cluster_name = module.ecs.ecs_cluster_name

# }