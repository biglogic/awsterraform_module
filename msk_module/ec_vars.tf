variable "ami" {
    type = string
    default = "ami-074251216af698218"
}
 variable "instancetype" {
     type = string
     default = "t2.large"
 }

 variable "instancekey"{
     type = string
     default = "ubuntu2"  
 }

variable "subnetid" {
     type = string
     default = "subnet-027ee1142a2b96b2f"
}

variable "security_group_id" {
      type = string
      default = "sg-0195185264086a144"
}
