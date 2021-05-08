provider "aws" {
  region = "us-east-2"
}

resource "aws_lambda_function" "lambda" {
  function_name                  = "${var.stage}-mybmi"
  handler                        = "src/index.performBMICalculation"
  memory_size                    = "256"
  timeout                        = 10
  reserved_concurrent_executions = "-1"
  s3_bucket                      = "krish-lambdas-bmicalc"
  s3_key                         = var.lambda_version
  role                           = aws_iam_role.bmi_lambda_iam_role.arn
  runtime                        = "nodejs14.x"
}

resource "aws_iam_role" "bmi_lambda_iam_role" {
  name               = "bmi_role_terr"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_api_gateway_resource" "mybmi" {
  parent_id   = aws_api_gateway_rest_api.bmi_api_gateway.root_resource_id
  path_part   = "mybmi"
  rest_api_id = aws_api_gateway_rest_api.bmi_api_gateway.id
}

resource "aws_api_gateway_method" "mybmi_get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.mybmi.id
  rest_api_id   = aws_api_gateway_rest_api.bmi_api_gateway.id
}

resource "aws_lambda_permission" "apigw" {
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowAPIGatewayInvoke"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.bmi_api_gateway.execution_arn}/*/*"
}

output "base_url" {
  value = aws_api_gateway_deployment.apigwdeployment.invoke_url
}