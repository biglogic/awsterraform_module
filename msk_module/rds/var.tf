variable "binlog_parameter" {
   type = string 
   default = "ROW"
}

variable "parameter_group_name"{
    type = string
    default = "rds-pg"
}

variable "parameter_group_family" {
    type = string
    default = "mysql8.0"
}

variable "database_identifier" {
    type = string
    default = "demodb"
  
}

variable "database_storage" {
  type = string
  default = 10
}

variable "database_engine_type" {
    type = string
    default = "mysql" 
    
}

variable "database_engine_version" {
    type = string
    default = "8.0"
}


variable "database_instance_class" {
    type = string
    default = "db.t3.micro"
}

variable "database_name" {
    type = string
    default = "mydb"
}

variable "username" {
     type = string
     default = "admin"
}

variable "password" {
     type = string 
     default = "password"
}

variable "snapshot"{
    type = bool
    default = true
}

variable "subnet_id" {
  type = list
  default = [
      "subnet-070f54bcbc095f16b",
      "subnet-056e079f0c02d9df0"
  ]
}

variable "tags" {
      type = map
      default = {
          name = "test"
      }
}