variable "pub_ami" {
  type = string
}

variable "pubinstance_type" {
   type = string
}

variable "instancekey_name" {
      type = string
}

variable "subpubid" {
     type = string
     
}

variable "broker" {
     type = string
     
}

variable "database_endpoint" {
     type = string
     
}

variable "database_server_name" {
       type = string
}

variable "database" {
      type = string
  
}

variable "table" {
   type = string 
}

variable "database_port" {
      type = number
}
variable "database_user" {
     type = string
  
}

variable "database_password" {
      type = string
  
}

variable "database_id" {
      type = number
  
}

variable "sg_id" {
      type = string
}
