# network.tf

resource "aws_vpc" "campaign_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "${var.campaign_prefix}-${var.campaign_name}"
  }
}

resource "aws_subnet" "campaign_subnet" {
  vpc_id            = aws_vpc.campaign_vpc.id
  cidr_block        = "172.16.10.0/24"

  tags = {
    Name = "${var.campaign_prefix}-${var.campaign_name}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.campaign_vpc.id
}

# Route the subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.campaign_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
