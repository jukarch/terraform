terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "<< your bucket name >>"
    key            = "<< s3 state file path >>"
    region         = "<< s3 region >>"
    encrypt        = true
    dynamodb_table = "<< dynamo table name >>"
  }
}
