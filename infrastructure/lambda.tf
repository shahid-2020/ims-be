module "create_organization_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.0"

  function_name = "create-organization-${terraform.workspace}"
  handler       = "index.handler"
  runtime       = "python3.12"

  source_path = "../src"

  publish = true

  allowed_triggers = {
    ApiGateway = {
      service = "apigateway"
      arn     = module.ims_api_gateway.api_execution_arn
    }
  }

  environment_variables = {
    ORGANIZATIONS_TABLE_ARN = module.organizations_table.dynamodb_table_arn
  }

  logging_log_group             = "/aws/${terraform.workspace}/lambda/create-organization"
  logging_application_log_level = "INFO"
  logging_log_format            = "JSON"

  cloudwatch_logs_retention_in_days = 7
}