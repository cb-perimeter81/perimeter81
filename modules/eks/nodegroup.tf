locals {
  node_group_name = "${var.name_prefix}-node-group"
}

data "local_file" "lb_policy" {
  filename = "${path.module}/loadbalancer-controller-policy.json"
}

resource "aws_iam_policy" "lb_policy" {
  name   = "cbrothers-lb-node-policy"
  policy = data.local_file.lb_policy.content
}

resource "aws_iam_role_policy_attachment" "lb_policy" {
  role       = aws_iam_role.node_group.name
  policy_arn = aws_iam_policy.lb_policy.arn
}

resource "aws_iam_role" "node_group" {
  name = local.node_group_name

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "worker_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = local.node_group_name
  node_role_arn   = aws_iam_role.node_group.arn

  subnet_ids = aws_subnet.public.*.id

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.small"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.worker_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy,
  ]
}
