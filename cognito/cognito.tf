resource "aws_cognito_user_pool" "user_pool" {
  name = "videoframe-pool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "videoframe-pool-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false
}

resource "aws_lambda_function" "post_auth_lambda" {
  filename         = "lambda/post_auth.zip"
  function_name    = "post-auth-lambda"
  runtime          = "python3.9"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.lambda_exec_role.arn

  source_code_hash = filebase64sha256("lambda/post_auth.zip")
}

resource "aws_cognito_user_pool_lambda_config" "lambda_trigger" {
  user_pool_id            = aws_cognito_user_pool.user_pool.id
  post_authentication     = aws_lambda_function.post_auth_lambda.arn
}
