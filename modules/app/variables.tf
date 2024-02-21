# k8s
variable "kubernetes_context" {
  description = "Name of the kubernetes context to use"
}

variable "kubernetes_config" {
  description = "Location of the kubernetes config"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
}

# app
variable "chart_version" {
  description = "App helm chart version"
}

variable "app_version" {
  description = "App version"
}

# oidc
variable "cluster_oidc_provider_arn" {
  description = "ARN of the IAM oidc provider"
}

variable "cluster_oidc_issuer_url" {
  description = "URL of the EKS oidc issuer"
}
