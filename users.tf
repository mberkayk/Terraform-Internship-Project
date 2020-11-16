resource "aws_iam_group" "s3-group" {
    name = "s3_group"
}

resource "aws_iam_user" "s3-user" {
  name = "s3-user"
}

resource "aws_iam_policy_attachment" "s3-group-attach" {
    name = "s3_group_attach"
    groups = [aws_iam_group.s3-group.name]
    policy_arn = "arn:aws:iam::427790202393:policy/S3-Policy"
}

resource "aws_iam_group_membership" "s3-users" {
    name = "s3-users"
    users = [
        aws_iam_user.s3-user.name,
    ]
    group = aws_iam_group.s3-group.name
}
 
resource "aws_iam_group" "ec2-group" {
    name = "ec2_group"
}

resource "aws_iam_user" "ec2-user" {
  name = "ec2-user"
}

resource "aws_iam_policy_attachment" "ec2-group-attach" {
    name = "ec2_group_attach"
    groups = [aws_iam_group.ec2-group.name]
    policy_arn = "arn:aws:iam::427790202393:policy/ec2-Policy"
}

resource "aws_iam_group_membership" "ec2-users" {
    name = "ec2-users"
    users = [
        aws_iam_user.ec2-user.name,
    ]
    group = aws_iam_group.ec2-group.name
}
