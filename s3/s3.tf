resource "aws_s3_bucket" "video_bucket" {
  bucket = "video-upload-bucket"

  versioning {
    enabled = true
  }

  notification {
    lambda_function {
      lambda_function_arn = aws_lambda_function.s3_event_lambda.arn
      events              = ["s3:ObjectCreated:*"]
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_event_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.video_bucket.arn
}
