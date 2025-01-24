resource "aws_ecr_repository" "systest_repo" {
  name                 = "systest-ecr-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

