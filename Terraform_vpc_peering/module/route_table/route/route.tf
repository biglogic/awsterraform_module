provider "aws" {
  region = "us-west-2"
  profile = "atul"
  # Requester's credentials.
}

provider "aws" {
  alias  = "peer"
  region = "us-west-1"
  profile = "atul"
  # Accepter's credentials.
}


resource "aws_route_table" "public_routable" {
    vpc_id = var.vpcid
    route {
    cidr_block = var.peer_cidr
    vpc_peering_connection_id = var.Accepter_id
    }
#
    tags = {
       Name = var.tags["rt1"]
  }

}



resource "aws_route_table" "peer" {
    vpc_id = var.vpcid_peer
    provider = aws.peer
    route {
       cidr_block = var.main_cidr
       vpc_peering_connection_id = var.Requester_id
    }
#
    tags = {
       Name = var.tags["rt1"]
  }

}

