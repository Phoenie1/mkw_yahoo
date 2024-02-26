
module "deploy_s3_bucket" {
  source                  = "./modules/s3"
  bucket                  = var.bucket
  force_destroy           = var.force_destroy
  versioning_status       = var.versioning_status
  object_ownership        = var.object_ownership

}

locals {
  bucket_arn = module.deploy_s3_bucket.bucket_arn
  kms_arn    = module.deploy_s3_bucket.kms_arn
  bucket_endpoint = module.deploy_s3_bucket.bucket_endpoint
}

module "schedule_trigger" {
  source = "./modules/eventbridge"

  event_name                  = var.event_name
  lambda_arn                  = local.lambda_arn
  lambda_function_name        = var.lambda_function_name
  schedule_expression         = var.schedule_expression
}

module "deploy_lambda_function" {
  source                  = "./modules/lambda"
  lambda_function_name    = var.lambda_function_name
  lambda_file             = var.lambda_file
  lambda_iam_role         = var.lambda_iam_role
  lambda_handler          = var.lambda_handler
  bucket                  = var.bucket
  bucket_arn              = local.bucket_arn
  kms_arn                 = local.kms_arn
}

locals {
  lambda_arn = module.deploy_lambda_function.lambda_arn
}

module "lambda-cf-edge-s3" {
  source = "./modules/lambdaatedge"

  arg = {
    # General variables
    name   = "mkw-deployment"
    tags   = { Name : "mkw_deployment" }
    region = "us-east-1" 

    # Full lambda function configuration
    lambda = {
      name        = var.lambdaatedge_name
      description = "Lambda@Edge: Authenticates CloudFront requests to S3 bucket containing maintenance web pages."

#      zip     = "./index.js.zip"
      handler = "index.handler"
      runtime = "nodejs18.x"
      memsize = "512"
      timeout = 30

      # Lambda versioning is needed for cloudfront association
      track-versions = true

      # Not a VPC function, so subnets and security groups are empty
      subnet-ids = []
      sg-ids     = []

      env = null

      policy-attachments = [
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ]

      policy = {
        Version = "2012-10-17",
        Statement = [{
          Effect = "Allow",
          Action = "sts:AssumeRole",
          Principal = {
            Service = [
              "lambda.amazonaws.com",
              "edgelambda.amazonaws.com"
            ]
          }
        }]
      }
    }
  }
}
