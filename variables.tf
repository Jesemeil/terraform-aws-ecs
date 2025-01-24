variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}

output "aws_region_used" {
  value       = var.aws_region
  description = "The AWS region where resources are deployed"
}
