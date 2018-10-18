variable "peer_owner_id" {
  description = "AWS account ID of requester"
  default     = ""
}

variable "name" {
  description = "Name of VPC peering"
  default     = ""
}
variable "requester_vpc_id" {
  description = "Requester VPC id"
  default     = ""
}

variable "accepter_vpc_id" {
  description = "Accepter VPC id"
  default     = ""
}

variable "create_vpc_peering" {
  description = "Enable VPC peering creation"
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}