output "aws_ecs_security_group_id" {
    value = aws_security_group.ecs_tasks.id
}

output "sg_lb_id" {
    value = aws_security_group.lb.id
}