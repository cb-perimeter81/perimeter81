locals {
  tags = {
    Name = "Corey Brothers"
    Owner = "Nati"
    Department = "DevOps"
    Temp = "True"
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "cbrothers-tfstate"
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    region         = get_env("AWS_REGION")
    encrypt        = true
    dynamodb_table = "flask-hello-world-lock-table"

    s3_bucket_tags         = local.tags
    dynamodb_table_tags = local.tags
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  name_prefix = "cbrothers"

  aws_region = get_env("AWS_REGION")
  tags = local.tags
}
