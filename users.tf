resource "aws_iam_user" "s3-user" {
  name = "s3-user"
}

resource "aws_iam_user" "ec2-user" {
  name = "ec2-user"
}
