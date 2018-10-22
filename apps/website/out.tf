output "cloudfront_domain_name" {
  value = "${aws_cloudfront_distribution.web.domain_name}"
}
