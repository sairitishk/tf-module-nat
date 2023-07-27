resource "aws_eip" "natgw-eip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw-eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.vpc_name}-NAT-GW"
  }
}

resource "aws_route" "nat_route" {
  route_table_id            = var.private_rt_id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id  = aws_nat_gateway.natgw.id
}