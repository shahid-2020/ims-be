module "organizations_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0"

  name = "organizations-${terraform.workspace}"

  billing_mode = "PAY_PER_REQUEST"

  deletion_protection_enabled    = terraform.workspace == "production"
  point_in_time_recovery_enabled = terraform.workspace == "production"

  hash_key  = "id"
  range_key = "created_at"

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "name"
      type = "S"
    },
    # {
    #   name = "industry"
    #   type = "S"
    # },
    {
      name = "status"
      type = "S"
    },
    # {
    #   name = "contactPersonDetails"
    #   type = "M"
    # },
    {
      name = "created_at"
      type = "S"
    },
    # {
    #   name = "updated_at"
    #   type = "S"
    # },
    # {
    #   name = "deleted_at"
    #   type = "S"
    # }
  ]

  global_secondary_indexes = [
    {
      name            = "name-index"
      hash_key        = "name"
      range_key       = "created_at"
      projection_type = "ALL"
    },
    {
      name            = "status-index"
      hash_key        = "status"
      range_key       = "created_at"
      projection_type = "ALL"
    }
  ]

}