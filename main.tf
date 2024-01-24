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

resource "snowflake_table" "example" {
  name     = "mytable"
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema.name

  column {
    name = "column1"
    type = "STRING"
  }

  column {
    name = "column2"
    type = "NUMBER"
  }
}

resource "snowflake_table" "example2" {
  name     = "mytable2"
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema.name

  column {
    name = "column1"
    type = "STRING"
  }

  column {
    name = "column2"
    type = "NUMBER(9,2)"
  }
}

resource "snowflake_table" "example3" {
  name     = "mytable3"
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema.name

  column {
    name = "column1"
    type = "STRING"
  }

  column {
    name = "column2"
    type = "NUMBER(9,2)"
  }
}