output "peer_owner_id" {
  description = "AWS account ID of requester"
  value       = "${module.vpc_peering.peer_owner_id}"
}

output "peer_vpc_id" {
  description = "The VPC Peer ID"
  value       = "${module.vpc_peering.peer_vpc_id}"
}