
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "aws-eks-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-eu-west-2a.id

  tags = {
    Name = "aws-eks-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}