output "ecr_repository_url" {
  value       = aws_ecr_repository.systest_repo.repository_url
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.systest_cluster.name
  description = "Name of the ECS cluster"
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.systest_cluster.arn
  description = "ARN of the ECS cluster"
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the ECS task execution role"
}

output "ecs_service_role_arn" {
  value       = aws_iam_role.ecs_service_role.arn
  description = "ARN of the ECS service role"
}



output "load_balancer_dns_name" {
  value       = aws_lb.systest_alb.dns_name
  description = "DNS name of the load balancer"
}



output "target_group_arn" {
  value       = aws_lb_target_group.systest_target_group.arn
  description = "ARN of the target group"
}



output "vpc_id" {
  value       = aws_vpc.systest_vpc.id
  description = "ID of the VPC"
}


output "subnet_ids" {
  value       = aws_subnet.systest_subnets[*].id
  description = "IDs of the subnets"
}

output "ecs_service_arn" {
  value       = aws_ecs_service.systest_service.id
  description = "ID of the ECS service (used as the ARN)"
}
