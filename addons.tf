# Define AWS CoreDNS addon
resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.aws-eks-cluster.name
  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

# Define kube-proxy addon
resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.aws-eks-cluster.name
  addon_name   = "kube-proxy"
}

# Define AWS VPC CNI addon
resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.aws-eks-cluster.name
  addon_name   = "vpc-cni"
}