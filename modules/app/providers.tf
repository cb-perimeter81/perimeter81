terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_context = var.kubernetes_context
    config_path    = var.kubernetes_config
  }
}
