data "aws_secretsmanager_secret" "secret" {
  arn = var.github_secret_arn
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = "${data.aws_secretsmanager_secret.secret.id}"
}

data "github_actions_public_key" "gh_actions_public_key" {
  repository = var.repo_name
}