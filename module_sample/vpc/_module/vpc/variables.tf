variable "cidr_numeral" {
  default = "10"
  type    = string
}

variable "vpc_name" {
  default = "foo-vpc"
  type    = string
}

variable "availability_zones" {
  type        = list(string)
  description = "A comma-delimited list of AZ"
}

variable "cidr_numeral_public" {
  type        = map(string)
  description = ""
  default = {
    "0" = "0"
    "1" = "16"
  }
}
