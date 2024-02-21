terraform {
  source = "../../modules/app"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = find_in_parent_folders("eks")
}

inputs = {
  cluster_name       = dependency.eks.outputs.cluster_name
  kubernetes_context = dependency.eks.outputs.cluster_name
  kubernetes_config  = get_env("KUBECONFIG", "${get_env("HOME")}/.kube/config")

  chart_version = "0.1.3"
  app_version = "0.1.5"

  cluster_oidc_provider_arn = dependency.eks.outputs.cluster_oidc_provider_arn
  cluster_oidc_issuer_url = dependency.eks.outputs.cluster_oidc_issuer_url
}
