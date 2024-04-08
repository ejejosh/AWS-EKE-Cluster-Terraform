# IAM role for eks

resource "aws_iam_role" "aws-eks-cluster" {
  name = "aws-eks-cluster"
  tags = {
    tag-key = "aws-eks-cluster"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# eks policy attachment

resource "aws_iam_role_policy_attachment" "aws-eks-cluster-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.aws-eks-cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# bare minimum requirement of eks

resource "aws_eks_cluster" "aws-eks-cluster" {
  name     = "aws-eks-cluster"
  role_arn = aws_iam_role.aws-eks-cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-eu-west-2a.id,
      aws_subnet.private-eu-west-2b.id,
      aws_subnet.public-eu-west-2a.id,
      aws_subnet.public-eu-west-2b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.aws-eks-cluster-AmazonEKSClusterPolicy]
}
