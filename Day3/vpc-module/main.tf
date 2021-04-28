data "aws_vpc" "anishvpc" {
  id =var.vpc_id
}

data "aws_availability_zones" "allazs" {
  
}

output "allazs" {
  value = data.aws_availability_zones.allazs
}

resource "aws_subnet" "appvpc_subnet" {
  count = length(data.aws_availability_zones.allazs.names)
  vpc_id = data.aws_vpc.anishvpc.id
  cidr_block = "10.0.${91+count.index}.0/28"
  availability_zone = data.aws_availability_zones.allazs.names[count.index]
  tags = {
    "Name" = "${var.subnet_prefix}-10.0.${91 +count.index}.0/28"
  }
}