module "vpc" {
  source             = "../_module/vpc"
  vpc_name           = "foo-dev-vpc"
  cidr_numeral       = "203"
  availability_zones = var.azs
  cidr_numeral_public = {
    "0" = "0"
    "1" = "16"
  }
}
