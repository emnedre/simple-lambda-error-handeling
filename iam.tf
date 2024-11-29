data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "SimpleLambdaErrorHandelingRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# add an AWS Managed IAM policy to the lambda IAM role
resource "aws_iam_role_policy_attachment" "aws_managed" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}