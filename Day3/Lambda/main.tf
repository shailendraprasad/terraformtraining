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

resource "aws_s3_bucket" "s3bucket" {
  bucket = "s3lambdatriggerexample-nsp"
}

resource "aws_cloudwatch_log_group" "cwlogs" {
  name              = "/aws/lambda/MyLambdaFunction-nsp"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging_nsp"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.mylmabdarole.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}