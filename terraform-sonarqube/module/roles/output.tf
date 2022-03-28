output "ecs_task_role_arn" {
    value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_attachment_arn" {
    value = aws_iam_role_policy_attachment.ecs_task_execution_role
}