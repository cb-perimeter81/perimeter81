data "local_file" "lb_policy" {
  filename = "${path.module}/loadbalancer-controller-policy.json"
}

resource "aws_iam_policy" "lb_policy" {
  name   = "cbrothers-lb-policy"
  policy = data.local_file.lb_policy.content
}

data "aws_iam_policy_document" "lb_controller_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.cluster_oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:default:cbrothers-cluster-alb-ingress",
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "lb_controller" {
  name               = "cbrothers-cluster-alb-ingress"
  assume_role_policy = data.aws_iam_policy_document.lb_controller_assume.json
}

resource "aws_iam_role_policy_attachment" "lb_controller" {
  role       = aws_iam_role.lb_controller.name
  policy_arn = aws_iam_policy.lb_policy.arn
}

resource "helm_release" "lb_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "default"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = "1.7.1"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = aws_iam_role.lb_controller.name
  }

  set {
    name  = "createIngressClassResource"
    value = "true"
  }
}
