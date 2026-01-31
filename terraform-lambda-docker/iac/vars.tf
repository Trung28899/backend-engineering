variable "aws_region" {
  type    = string
  default = "ca-central-1"
}

variable "aws_profile" {
  type    = string
  default = "default" # profile from ~/.aws/credentials
}
