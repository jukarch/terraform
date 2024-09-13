module "ec2" {
  source            = "../_module/ec2"
  ec2_instance_type = "t3.micro"
  ec2_name          = "foo-ec2"
  ec2_ami           = "ami-0182f373e66f89c85"
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnets    = ["subnet-xxxxx", "subnet-0xxxx"]
}
