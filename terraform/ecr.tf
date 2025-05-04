#
# Elastic Container Registry (ECR)
#

resource "aws_ecr_repository" "backend_services" {
  name                 = "ctf-backend-services"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.ctf_tags
}

output "ecr_repository_url" {
  value = aws_ecr_repository.backend_services.repository_url
}