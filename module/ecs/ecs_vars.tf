variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "nginx:latest"
}
variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "ecs_task_role_arn" {
      
}


variable "pvt_subnets" {

}

variable "aws_alb_target_group_id" {
  
}

variable "ecs_security_group_id" {
  
}

variable "alb_listners_frontend" {
  
}

variable "iam_role_attachment" {
  
}