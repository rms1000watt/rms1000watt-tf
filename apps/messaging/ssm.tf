data "aws_ssm_parameter" "slack_webhook_url" {
  name = "slack-webhook-url"
}
