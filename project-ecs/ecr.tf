# ecr.tf | Elastic Container Repository
# The ECR is a repository where we're gonna store the Docker Images of the application we want to deploy
resource "aws_ecr_repository" "aws-ecr" {
  name = "${var.app_name}-${var.app_environment}-ecr"
  tags = {
    Name        = "${var.app_name}-ecr"
    Environment = var.app_environment
  }
}