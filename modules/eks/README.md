## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.37.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_access_policy_association.k8s_admin](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.default](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.lb_policy](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.cluster](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role) | resource |
| [aws_iam_role.k8s_admin](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role) | resource |
| [aws_iam_role.node_group](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cni_policy](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lb_policy](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_policy](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.inet_gateway](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/internet_gateway) | resource |
| [aws_route.inet_gateway](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/route_table_association) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/security_group) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.37.0/docs/data-sources/caller_identity) | data source |
| [local_file.lb_policy](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy to | `any` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to use for naming of resources | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_admin_iam_role_arn"></a> [cluster\_admin\_iam\_role\_arn](#output\_cluster\_admin\_iam\_role\_arn) | IAM role arn that maps to a k8s admin |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the EKS cluster created |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | URL of the EKS oidc issuer |
| <a name="output_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#output\_cluster\_oidc\_provider\_arn) | ARN of the IAM oidc provider |
