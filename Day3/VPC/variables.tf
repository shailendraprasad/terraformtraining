variable "cidr_block" {
  default = "10.1.0.0/16"
  description = "CIDR block to be used for vpc creation"
}

variable "pvtsubnet_cidr_block" {
  default = "10.1.0.0/24"
  description = "CIDR block to be used for subnet creation"
}