
variable "aws_region" {
  default = "eu-central-1"
}

variable "bucket_name" {
  default = "example-bucket"
}

variable "security_group_name" {
  default = "terraform-example"
}

variable "security_group_description" {
  default = "terraform-description"
}

variable "aws_amis" {
  default = {
    eu-central-1 = "ami-fa2fb595"
    eu-west-1 = "ami-674cbc1e"
    us-east-1 = "ami-1d4e7a66"
    us-west-1 = "ami-969ab1f6"
    us-west-2 = "ami-8803e0f0"
  }
}

