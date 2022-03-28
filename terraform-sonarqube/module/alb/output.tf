output "aws_alb_target_group_id" {
    value = aws_alb_target_group.app.id
}

output "aws_alb_listene_frint_end" {
    value = aws_alb_listener.front_end
}

output "alb_hostname" {
  value = aws_alb.main.dns_name
}