resource "aws_vpc" "myappvpc" {
  cidr_block = var.cidr_block
  tags = {
      Name = "nsp-vpc"
  }
}

resource "aws_subnet" "pvtsubnet" {
  cidr_block = var.pvtsubnet_cidr_block
  vpc_id = aws_vpc.myappvpc.id
  tags = {
      Name = "nsp-${var.pvtsubnet_cidr_block}-private"
  }
  depends_on = [
    aws_vpc.myappvpc
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myappvpc.id
  tags = {
    "Name" = "nsp-myappvpc-igw"
  }
}



resource "aws_subnet" "pvtsubnet" {
  cidr_block = "10.0.10.0/24"
  vpc_id = "vpc-03f094db73a5298e9"
  tags = {
      Name = "nsp-givenip-private"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "vpc-03f094db73a5298e9"
}

resource "aws_route_table_association" "routeassociate" {
  subnet_id = aws_subnet.pvtsubnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route" "natroute" {
    nat_gateway_id = "nat-0d649473777db8806"
    route_table_id = aws_route_table.rt.id
    destination_cidr_block =  "0.0.0.0/24"
  
}