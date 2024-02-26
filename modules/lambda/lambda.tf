data "aws_caller_identity" "current" {
}

resource "aws_iam_role" "this" {
  name = var.lambda_iam_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  inline_policy {
    name = "lambda_execution_policy"

    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "LogPolicies1",
            "Effect": "Allow",
            "Action": [
	        "logs:CreateLogStream",
	        "logs:PutLogEvents"
	    ]
	    "Resource": "arn:aws:logs:us-east-1:508563857051:log-group:/aws/lambda/${var.lambda_function_name}:*"
        },
        {
            "Sid": "LogPolicies2",
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-east-1:508563857051:*"
	},
        {
            "Sid": "KMS2",
            "Effect": "Allow",
            "Action": "kms:GenerateDataKey",
            "Resource": "${var.kms_arn}"
	},
        {
            "Sid": "s3Policies",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "${var.bucket_arn}/*"
        }
      ]
    })
   }
}

resource "aws_lambda_function" "this" {
  function_name    = var.lambda_function_name
  filename         = "${path.module}/${var.lambda_file}"
  role             = aws_iam_role.this.arn
  handler          = var.lambda_handler
  runtime          = "python3.8"

  tags = {
    "app_name"    = var.lambda_function_name
    "created_arn" = data.aws_caller_identity.current.arn
  }

}


