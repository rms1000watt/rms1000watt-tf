resource "aws_iam_role" "0" {
  name               = "${local.role_name}"
  assume_role_policy = "${file("role.json")}"
}

resource "aws_iam_role_policy" "0" {
  name   = "${local.policy_name}"
  role   = "${aws_iam_role.0.name}"
  policy = "${file("policy.json")}"
}
