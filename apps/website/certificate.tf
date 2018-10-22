provider "aws" {
  alias  = "east1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  provider    = "aws.east1"
  domain_name = "${var.domain_name}"

  subject_alternative_names = [
    "api.${var.domain_name}",
    "www.${var.domain_name}",
  ]

  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation_1" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${var.route53_zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "cert_validation_2" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_type}"
  zone_id = "${var.route53_zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.1.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "cert_validation_3" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.2.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.2.resource_record_type}"
  zone_id = "${var.route53_zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.2.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider        = "aws.east1"
  certificate_arn = "${aws_acm_certificate.cert.arn}"

  validation_record_fqdns = [
    "${aws_route53_record.cert_validation_1.fqdn}",
    "${aws_route53_record.cert_validation_2.fqdn}",
    "${aws_route53_record.cert_validation_3.fqdn}",
  ]
}
