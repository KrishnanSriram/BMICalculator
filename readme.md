### Node-AWS- Terraform

A simple example to demonstrate how to do simple terraform functionality

#### Execution
* Compile NodeJS code locally and test it locally through local/local_lambda.js
* Upload code as a zip file over to S3
* Update location of zip file in "lambda.bmi.tf" line 11 (s3_bucket)
* terraform init 
* terraform apply

##### Note
You can do terraform apply and suply all commands like below
terraform apply -var="aws_account=<<accountid>>" -var="lambda_version=<<zip file in s3>>" -var="stage=dev"
terraform apply -var="aws_account=4e7853fr87" -var="lambda_version=bmi_202105071415.zip" -var="stage=dev"