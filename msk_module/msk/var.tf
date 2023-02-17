variable "vpc_id" {
  type = string
}

variable "mskinstancetype" {
     type = string
     default = "kafka.m5.large"
}

variable "mskinstancesubnet" {

}

variable "client_broker" {
  type        = string
  description = "Encryption setting for data in transit between clients and brokers. Valid values: `TLS`, `TLS_PLAINTEXT`, and `PLAINTEXT`"
}

variable "encryption_in_cluster" {
  description = "Whether data communication among broker nodes is encrypted"
}

variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest"
}


