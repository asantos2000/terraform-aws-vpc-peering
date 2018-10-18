output "peer_owner_id" {
  description = "The requester account id" 
  value       = "${aws_vpc_peering_connection.requester2accepter.*.peer_owner_id}"
}

output "peer_vpc_id" {
  description = "The VPC Peer ID"
  value       = "${aws_vpc_peering_connection.requester2accepter.*.id}"
}
