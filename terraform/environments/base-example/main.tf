
# terraform validate will flag wrong resource type
resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name
}

# terraform validate will flag this as wrong
resource "aws_vpc" "default" {
  # wrong CIDR block is caught by validate
  //cidr_block = "0.0.0.0/0"
  cidr_block = "10.0.0.0/16"
}

# ... but not the wrong instance type:
resource "aws_instance" "web" {

  # wrong instance type is not caught by terraform validate
//  instance_type = "t200.micro"
  instance_type = "t2.micro"

  ami                    = var.aws_amis[var.aws_region]
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id              = aws_subnet.default.id

}

# Note: do NOT declare security groups with rules defined directly, as it is not recommended!
resource "aws_security_group" "default" {
  name        = var.security_group_name
  description = var.security_group_name
  vpc_id      = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}
