output "vpc_id" {
  value = aws_vpc.default.id
}

output "vpc_name" {
  value = var.vpc_name
}

output "cidr_block" {
  value = aws_vpc.default.cidr_block
}
