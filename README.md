# Introduction 
This is a description of Matthew White's implementation of this exercise.

# Structure of repo

1.	The "root" directory contains the main, variables, and tfvars files for everything.  Just run terraform init, plan, and apply in here and it will deploy.
2.	The "Modules" folder contains modules for configuring every major element of the solution - the Lambda script, Eventbridge trigger, s3 bucket, Cloudfront implementation.  Outputs from each module are used in the main.tf to feed arn's to each other module as needed for configurations.
3.	Anciliary things like IAM Roles are included in the module with the element they support.
4.	API references

# Build and Test
Just run terraform init, plan, and apply in here and it will deploy.

# Tear down 
Terraform destroy.
