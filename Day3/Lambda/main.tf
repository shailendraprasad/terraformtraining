resource "aws_lambda_function" "myfunction" {
  function_name = "MyLambdaFunction-nsp"
  handler = "lambdaHandler"
  filename = "lambda.py.zip"
  source_code_hash = filebase64sha256("lambda.py.zip")
  runtime = "python3.8"
  role = aws_iam_role.mylmabdarole.arn
}

resource "aws_iam_role" "mylmabdarole" {
  name = "iam_for_lambda_nsp"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}