module "serverless" {
  source  = "rms1000watt/serverless-tf/aws"
  version = "0.2.18"

  functions = [
    {
      file    = "${var.lambda_file_authorizer}"
      name    = "authorizer"
      rebuild = "always"
    },
    {
      file     = "${var.lambda_file_messenger}"
      name     = "messanger"
      rebuild  = "always"
      role_arn = "arn:aws:iam::${local.account_id}:role/${local.role_name}"

      http_path       = "message"
      http_method     = "POST"
      http_authorizer = "authorizer"

      env_keys = "SLACK_WEBHOOK_URL"
      env_vals = "${data.aws_ssm_parameter.slack_webhook_url.value}"
    },
  ]
}
