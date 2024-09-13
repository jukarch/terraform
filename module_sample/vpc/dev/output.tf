output "vpc_id" {
  value = module.vpc.aws_vpc.default.id
}

output "cidr_block" {
  value = module.vpc.aws_vpc.default.cidr_block
}

output "public_subnets" {
  value = module.vpc.aws_subnet.public.*.id
}
