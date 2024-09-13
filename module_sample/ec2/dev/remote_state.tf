data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "<< backend buckert >>"
    key    = "<< backend file >>"
    region = "<< region >>"
    #role_arn     = var.assume_role_arn
    #session_name = var.atlantis_user
  }
}
