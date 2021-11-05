provider "aws" {
    region = "us-west-2"
    profile = "atul"
}

provider "aws" {
    alias = "peer" 
    region = "us-west-1"
    profile = "atul" 
}



resource "aws_vpc" "biglogic_vpc" {
  cidr_block           = var.request_cidr
  tags = var.tags
}

resource "aws_vpc" "peer" {
  cidr_block           = var.peer_cidr
  provider = aws.peer
  tags = var.tags
}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.biglogic_vpc.id
  peer_vpc_id   = aws_vpc.peer.id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = var.peer_region
  auto_accept   = false 

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.


resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}