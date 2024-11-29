variable "prefix" {
  type    = string
  default = "lambda-error-handeling"
}

# give me the data block for the current region
data "aws_region" "current" {}
