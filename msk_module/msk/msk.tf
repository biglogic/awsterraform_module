locals {


  # var.client_broker types
  plaintext     = "PLAINTEXT"
  tls_plaintext = "TLS_PLAINTEXT"
  tls           = "TLS"

  # The following ports are not configurable. See: https://docs.aws.amazon.com/msk/latest/developerguide/client-access.html#port-info
  protocols = {
    plaintext = {
      name = "plaintext"
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster#bootstrap_brokers
      enabled = contains([local.plaintext, local.tls_plaintext], var.client_broker)
      port    = 9092
    }
    tls = {
      name = "TLS"
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster#bootstrap_brokers_tls
      enabled = contains([local.tls_plaintext, local.tls], var.client_broker)
      port    = 9094
    }
  }
}



resource "aws_msk_configuration" "example" {
  kafka_versions = ["2.1.0"]
  name           = "example"

  server_properties = <<PROPERTIES
auto.create.topics.enable=TRUE
default.replication.factor=2
min.insync.replicas=2
num.io.threads=8
num.network.threads=5
num.partitions=1
num.replica.fetchers=2
replica.lag.time.max.ms=30000
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
socket.send.buffer.bytes=102400
unclean.leader.election.enable=true
zookeeper.session.timeout.ms=18000
zookeeper.connection.timeout.ms=18000
PROPERTIES
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      =  var.vpc_id
  
  dynamic "ingress" {
      for_each = local.protocols
      content{  
          description      = "tls"
          from_port        = ingress.value["port"]
          to_port          = ingress.value["port"]
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
      }   
    
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_cloudwatch_log_group" "test" {
  name = "msk_broker_logs"
}



resource "aws_msk_cluster" "example" {
  cluster_name           = "example"
  kafka_version          = "2.6.1"
  number_of_broker_nodes = 2

  configuration_info {
    arn      = aws_msk_configuration.example.arn
    revision = aws_msk_configuration.example.latest_revision
  }
  


  broker_node_group_info {
    instance_type   = var.mskinstancetype
    ebs_volume_size = 1000
    client_subnets = [
      "subnet-0fdecf2eaebd4d0c2",
      "subnet-0be02bec98bbf4cf1",
      
    ]
    security_groups = [aws_security_group.allow_tls.id]
  }

  encryption_info {
      encryption_in_transit {
        client_broker = var.client_broker
        in_cluster    = var.encryption_in_cluster
      }
      encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn
    }


  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.test.name
      }
    }
  }

  tags = {
    foo = "bar"
  }
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.example.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.example.bootstrap_brokers
}
