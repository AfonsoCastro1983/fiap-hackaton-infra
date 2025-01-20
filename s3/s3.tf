resource "aws_s3_bucket" "video_bucket" {
  bucket = "video-upload-bucket"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Video Upload Bucket"
    Environment = "Production"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.video_bucket.bucket
}