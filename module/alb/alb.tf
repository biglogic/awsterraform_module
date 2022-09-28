# alb.tf

resource "aws_alb" "main" {
  name            = "myapp-load-balancer"
  subnets         = var.vpc_subnets
  security_groups = [var.sg_lb_id]
}

# resource "aws_alb_target_group" "app" {
#   name        = "myapp-target-group"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = var.vpc_id
#   target_type = "ip"

#   health_check {
#     healthy_threshold   = "3"
#     interval            = "30"
#     protocol            = "HTTP"
#     matcher             = "200"
#     timeout             = "3"
#     path                = var.health_check_path
#     unhealthy_threshold = "2"
#   }
# }

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.tg_id
    type             = "forward"
  }
}


resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  count = var.listener_rule == null ? 0 : 1
  listener_arn = aws_alb_listener.front_end.arn
  # priority     = count.index+1
  
  action {
    type             = "forward"
    target_group_arn = var.listener_rule[count.index].target_group_arn
  }

  dynamic "condition" {
    for_each = [
      for x, condition_rule in var.listener_rule:
      condition_rule
      if "path_pattern" == condition_rule.conditions
    ]

    content {
      path_pattern {
        values = condition.value["value"]
      }
    }
  }
  dynamic "condition" {
    for_each = [
      for condition_rule in var.listener_rule:
      condition_rule
      if "host_header" == condition_rule.conditions
    ]

    content {
      host_header{
        values = condition.value["value"]
      }
    }
  }      
}


  # Http header condition
#   dynamic "condition" {
#     for_each = [
#       for condition_rule in var.listener_rule[count.index].condition :
#       condition_rule
#       if length(lookup(condition_rule, "http_headers", [])) > 0
#     ]

#     content {
#       dynamic "http_header" {
#         for_each = condition.value["http_headers"]

#         content {
#           http_header_name = http_header.value["http_header_name"]
#           values           = http_header.value["values"]
#         }
#       }
#     }
#   }

#   # Http request method condition
#   dynamic "condition" {
#     for_each = [
#       for condition_rule in var.listener_rule[count.index].condition :
#       condition_rule
#       if length(lookup(condition_rule, "http_request_methods", [])) > 0
#     ]

#     content {
#       http_request_method {
#         values = condition.value["http_request_methods"]
#       }
#     }
#   }

#   # Query string condition
#   dynamic "condition" {
#     for_each = [
#       for condition_rule in var.listener_rule[count.index].condition :
#       condition_rule
#       if length(lookup(condition_rule, "query_strings", [])) > 0
#     ]

#     content {
#       dynamic "query_string" {
#         for_each = condition.value["query_strings"]

#         content {
#           key   = lookup(query_string.value, "key", null)
#           value = query_string.value["value"]
#         }
#       }
#     }
#   }

#   # Source IP address condition
#   dynamic "condition" {
#     for_each = [
#       for condition_rule in var.listener_rule[count.index].condition :
#       condition_rule
#       if length(lookup(condition_rule, "source_ips", [])) > 0
#     ]

#     content {
#       source_ip {
#         values = condition.value["source_ips"]
#       }
#     }
#   }

# }

  
# resource "aws_lb_listener_rule" "backend" {
#   listener_arn = aws_alb_listener.front_end.arn
#   priority     = 2
  
#   action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.app.id
#   }

#    condition {
#     host_header {
#       values = ["example.com"]
#     }
#   }
# }  

# resource "aws_lb_listener_rule" "backend_yet" {
#   listener_arn = aws_alb_listener.front_end.arn
#   priority     = 3
  
#   action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.app.id
#   }

#    condition {
#     host_header {
#       values = ["example.com.in"]
#     }
#   }
# }  