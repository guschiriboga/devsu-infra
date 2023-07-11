variable "region" {
  description = "AWS Region"
}

variable "project_name" {
  description = "Project name"
}
variable "cidr_info" {
  description = "Main CIDR info for VPC and subnets"
}

locals {
  subnet_count = 2
  subnet_newbits = 8
}