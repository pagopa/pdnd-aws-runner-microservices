variable "repo_name" {
  type        = string
  description = "This repo name"
}
variable "repo_owner" {
  type        = string
  description = "github organization"
}
variable "github_secret_arn" {
  type        = string
  description = "AWS secret for github"
}

variable "nexus_secret_arn" {
  type        = string
  description = "AWS secret for nexus credentials"
}

variable "image_registry_url" {
  type        = string
  description = "docker registry url"
}
variable "runner_cluster_name" {
  type        = string
  description = "cluster name of the runners"
}
variable "runner_service_account" {
  type        = string
  description = "service account used by runners"
}
variable "runner_k8s_namespace" {
  type        = string
  description = "k8s namespace of the runners"
}