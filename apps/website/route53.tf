resource "aws_route53_record" "root" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.web.domain_name}"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${var.route53_zone_id}"
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 60
  records = ["${var.domain_name}"]
}
