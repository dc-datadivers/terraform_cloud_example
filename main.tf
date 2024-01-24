#Terraform example
terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "example-org-aa24dd"

    workspaces {
      name = "Terraform_Cloud_Example"
    }
  }
}

provider "snowflake" {
}

resource "snowflake_database" "demo_db" {
  name    = "DEMO_DB"
  comment = "Database for Snowflake Terraform demo"
}

resource "snowflake_schema" "demo_schema" {
  database = snowflake_database.demo_db.name
  name     = "DEMO_SCHEMA"
  comment  = "Schema for Snowflake Terraform demo"
}

resource "snowflake_table" "table" {
  database            = "DEMO_DB"
  schema              = "DEMO_SCHEMA"
  name                = "table1"
  comment             = "A table."

  column {
    name     = "id"
    type     = "int"
    nullable = true

    default {
      sequence = snowflake_sequence.sequence.fully_qualified_name
    }
  }

  column {
    name     = "identity"
    type     = "NUMBER(38,0)"
    nullable = true

    identity {
      start_num = 1
      step_num  = 3
    }
  }
}
