
output "bucket_name" {
  value = aws_s3_bucket.default.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.default.arn
}

output "vpc_id" {
  value = aws_vpc.default.id
}

output "vpc_cidr" {
  value = aws_vpc.default.cidr_block
}

output "instance_security_groups" {
  value = aws_instance.web.security_groups
}

output "security_group_id" {
  value = aws_security_group.default.id
}

output "security_group_name" {
  value = aws_security_group.default.name
}

output "security_group_vpc_id" {
  value = aws_security_group.default.vpc_id
}
