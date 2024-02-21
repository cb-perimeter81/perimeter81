# common
variable "name_prefix" {
  description = "Prefix to use for naming of resources"
}

# aws
variable "aws_region" {
  description = "AWS region to deploy to"
}

variable "tags" {
  default     = {}
  description = "Tags for AWS resources"
  type        = map(string)
}
