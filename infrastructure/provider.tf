provider "aws" {
  default_tags {
    tags = {
      Environment = terraform.workspace
      ManagedVia  = "Terraform"
      Project     = var.github_project_url
    }
  }
}