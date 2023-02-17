provider "aws" {
    profile = ""
    region  = ""
  
}

# module "ec2" {
#   source           = "./ec2"
#   pub_ami          = var.ami
#   pubinstance_type = var.instancetype
#   instancekey_name = var.instancekey
#   sg_id   =   var.security_group_id
#   subpubid = var.subnetid
#   broker = module.msk.bootstrap_brokers
#   database_endpoint = module.rds.database_endpoint
#   database_server_name = var.database_server_name
#   database = var.database
#   table = var.table
#   database_port = var.database_port
#   database_user = var.database_user
#   database_password = var.database_password
#   database_id = var.database_id

# }

module "msk" {
    vpc_id = var.vpc_id 
    source = "./msk"
    mskinstancesubnet = var.msk_instance_subnet
    mskinstancetype = var.msk_instance_type
    client_broker = var.msk_broker
    encryption_in_cluster =  var.msk_cluster_encryption
    encryption_at_rest_kms_key_arn = var.msk_encryption_at_rest_kms_key_arn
}

# module "rds" {

#   source = "./rds"
#   database_identifier = var.database_server_name
#   database_name = var.database
#   username = var.database_user
#   password = var.database_password

# }
