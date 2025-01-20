resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_exec_policy" {
  name = "lambda-exec-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "cognito-idp:*",
          "dynamodb:*",
          "s3:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_role_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_exec_policy.arn
}

resource "aws_lambda_function" "post_auth_lambda" {
  filename         = "lambda/post_auth.zip"
  function_name    = "post-auth-lambda"
  runtime          = "python3.9"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.lambda_exec_role.arn

  source_code_hash = filebase64sha256("lambda/post_auth.zip")
}

resource "aws_cognito_user_pool" "user_pool" {
  name = "videoframe-pool"

  lambda_config {
    post_authentication = aws_lambda_function.post_auth_lambda.arn
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "videoframe-pool-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false
}
