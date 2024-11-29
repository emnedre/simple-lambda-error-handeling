resource "aws_lambda_function" "lambda_error_handeling_function" {
  function_name    = "${var.prefix}-function"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda_handler.lambda_handler"
  runtime          = "python3.13"
  timeout          = 15
}
# create the lambda layer for powertools

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "lambda_layer/powertools_layer.zip"
  layer_name = "powertools_layer"
  depends_on = [
    aws_lambda_function.lambda_error_handeling_function
  ]
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda/lambda_handler.py"
  output_path = "lambda/payload/lambda_error_handeler.py"
}