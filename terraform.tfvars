bucket               = "mkw-bucket-b4432"
event_name           = "FireLambdaEveryTenMinutes"
lambda_file          = "/functioncode/write_file_to_s3.zip"
lambda_function_name = "mkw_lambda_file_serve"
lambda_handler       = "write_file_to_s3.lambda_handler"
lambda_iam_role      = "mkw_iam_file_serve"
object_ownership     = "BucketOwnerPreferred"
schedule_expression  = "rate(10 minutes)"
tags                 = {
    Name = "mkw_test"
}
versioning_status    = "Enabled"
lambdaatedge_name    = "mkw_test_1"
