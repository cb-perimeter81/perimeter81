# eks
output "cluster_name" {
  description = "Name of the EKS cluster created"
  value = aws_eks_cluster.cluster.name
}

output "cluster_admin_iam_role_arn" {
  description = "IAM role arn that maps to a k8s admin"
  value = aws_iam_role.k8s_admin.arn
}

# oidc
output "cluster_oidc_provider_arn" {
  description = "ARN of the IAM oidc provider"
  value = aws_iam_openid_connect_provider.eks.arn
}

output "cluster_oidc_issuer_url" {
  description = "URL of the EKS oidc issuer"
  value = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}
