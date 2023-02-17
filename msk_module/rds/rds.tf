resource "aws_db_parameter_group" "default" {
  name   = var.parameter_group_name
  family = var.parameter_group_family

  parameter {
    name  = "binlog_format"
    value = var.binlog_parameter
  }

}

resource "aws_db_instance" "default" { 
  identifier =  var.database_identifier     
  allocated_storage    = var.database_storage
  engine               = var.database_engine_type
  engine_version       = var.database_engine_version
  instance_class       = var.database_instance_class
  db_name              = var.database_name
  username             = var.username
  password             = var.password
  parameter_group_name = aws_db_parameter_group.default.id
  skip_final_snapshot  = var.snapshot
  db_subnet_group_name = aws_db_subnet_group.default.id
}

resource "aws_db_subnet_group" "default" {
  name       = "subnet_group"
  subnet_ids = var.subnet_id
  tags = { 
             Name = var.tags["name"] 
       } 
}

output "database_endpoint" {
    value       = aws_db_instance.default.address
}