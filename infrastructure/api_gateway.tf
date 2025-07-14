module "ims_api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 5.0"

  name          = "ims-${terraform.workspace}"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["*"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  hosted_zone_name            = local.domain
  domain_name                 = local.fully_qualified_domain_name
  domain_name_certificate_arn = aws_acm_certificate.cert.arn

  stage_access_log_settings = {
    create_log_group            = true
    log_group_name              = "/aws/${terraform.workspace}/apigateway/ims"
    log_group_retention_in_days = 7
    format = jsonencode({
      context = {
        domainName              = "$context.domainName"
        integrationErrorMessage = "$context.integrationErrorMessage"
        protocol                = "$context.protocol"
        requestId               = "$context.requestId"
        requestTime             = "$context.requestTime"
        responseLength          = "$context.responseLength"
        routeKey                = "$context.routeKey"
        stage                   = "$context.stage"
        status                  = "$context.status"
        error = {
          message      = "$context.error.message"
          responseType = "$context.error.responseType"
        }
        identity = {
          sourceIP = "$context.identity.sourceIp"
        }
        integration = {
          error             = "$context.integration.error"
          integrationStatus = "$context.integration.integrationStatus"
        }
      }
    })
  }

  routes = {
    "GET /api/v1/organizations" = {
      integration = {
        uri                    = module.create_organization_lambda.lambda_function_invoke_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
  }

}