
//https://github.com/integrations/terraform-provider-github/issues/888 encrypted value?
resource "github_actions_secret" "github_token" {
  repository       = var.repo_name
  secret_name      = "PAT_BOT"
  plaintext_value  = jsondecode(data.aws_secretsmanager_secret_version.github_current.secret_string)["PAT_BOT"]
}

resource "github_actions_secret" "aws_runner_deploy_role" {
  repository       = var.repo_name
  secret_name      = "RUNNER_DEPLOY_ROLE"
  plaintext_value = jsondecode(data.aws_secretsmanager_secret_version.github_current.secret_string)["RUNNER_DEPLOY_ROLE"]
}

resource "github_actions_variable" "runner_cluster_name" {
  repository       = var.repo_name
  variable_name    = "RUNNER_CLUSTER_NAME"
  value            = var.runner_cluster_name
}

resource "github_actions_variable" "runner_service_account" {
  repository       = var.repo_name
  variable_name    = "RUNNER_SERVICE_ACCOUNT"
  value            = var.runner_service_account
}

resource "github_actions_variable" "runner_k8s_namespace" {
  repository       = var.repo_name
  variable_name    = "RUNNER_K8S_NAMESPACE"
  value            = var.runner_k8s_namespace
}