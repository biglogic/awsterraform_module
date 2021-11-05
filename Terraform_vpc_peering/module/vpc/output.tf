output "requester_vpc" {
  value = aws_vpc.biglogic_vpc.id
}

output "accepter_vpc" {
  value = aws_vpc.peer.id
}

output "main_peer_id" {
    value =  aws_vpc_peering_connection.peer.id 
  }

output "peer_id" {
  value = aws_vpc_peering_connection_accepter.peer.id 
}  