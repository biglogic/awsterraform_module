variable "vpc_id" {
  
}

variable "vpc_subnets" {
   
}

variable "sg_lb_id" {
   
}

variable "health_check_path" {
  default = "/"
}

variable "app_port" {
  default = 80
}

# variable "listener_rule" {
#   description = "List of parameters for listener_rule"
#   type = list
#   default = ["example.com","example.com.in","example.com.2"]
# }

variable "listener_rule" {
  description = "List of parameters for listener_rule"
  type = list(object({
    listener_arn       = string
    target_group_arn = string
    conditions       = string
    value   = list(string)
  }))
}

variable "listner_val" {
  type = any
  default = null
}

variable tg_id {
  type = string
}