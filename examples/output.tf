output "peer_owner_id" {
  description = "The CIDR block of the VPC"
  value       = "${module.vpc_peering.peer_owner_id}"
}

output "peer_vpc_id" {
  description = "The CIDR block of the VPC"
  value       = "${module.vpc_peering.peer_vpc_id}"
}