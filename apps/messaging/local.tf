data "aws_caller_identity" "0" {}

locals {
  user_id    = "${data.aws_caller_identity.0.user_id}"
  account_id = "${data.aws_caller_identity.0.account_id}"

  role_name   = "messaging-${var.environment}"
  policy_name = "messaging-${var.environment}"
}
