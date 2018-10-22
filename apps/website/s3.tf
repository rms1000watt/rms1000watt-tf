resource "aws_s3_bucket" "web" {
  bucket = "bucket.${var.domain_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}
