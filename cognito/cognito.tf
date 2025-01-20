resource "aws_cognito_user_pool" "user_pool" {
  name = "videoframe-pool"

  schema {
    attribute_data_type = "String"
    name               = "email"
    required           = true
    mutable            = false
  }

  schema {
    attribute_data_type = "String"
    name               = "name"
    required           = false
    mutable            = true
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "videoframe-pool-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]

  generate_secret = false
}

output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}