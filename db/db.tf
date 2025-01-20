resource "aws_dynamodb_table" "videos_table" {
  name         = "VideosTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "videoId"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "videoId"
    type = "S"
  }
}
