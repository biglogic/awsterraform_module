# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "sonarqube"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 9000
}

variable "tg_id" {
  type = string
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "health_check_path" {
  default = "/"
}


variable "tg_name" {
   type = list
   default = ["my-app","my-app-ecs"]  
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "vpc_id" {

}

variable "vpc_subnets" {

}

variable "sg_lb_id" {

}

variable "ecs_task_role_arn" {

}


variable "pvt_subnets" {

}

variable "aws_alb_target_group_id" {

}
variable "alb_listners_frontend" {

}

variable "iam_role_attachment" {

}