variable "vpc_id" {
  description = "VPC ID in which subnets are to be created"
}

variable "subnet_prefix" {
    description = "Prefix for subnet, this will be added to subnet name"
}