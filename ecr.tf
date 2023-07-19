resource "aws_ecr_repository" "main" {
  name         = "h4b-ecs-helloworld"
  force_delete = true
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}