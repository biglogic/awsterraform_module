variable "vpc_id" {
   type = string
   default = "vpc-d708f1ae"

}

variable "msk_instance_subnet" {
      type = list
      default = [
      "subnet-0be02bec98bbf4cf1",
      "subnet-0fdecf2eaebd4d0c2",
      ]
}

variable "msk_instance_type" {
      type = string
      default = "kafka.m5.large"
}
variable "msk_broker" {
      type = string
      default = "TLS_PLAINTEXT"
}

variable "msk_cluster_encryption" {
  type = bool
  default = "true"
}
variable "msk_encryption_at_rest_kms_key_arn" {
  type        = string
  default     = ""
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest"
}
