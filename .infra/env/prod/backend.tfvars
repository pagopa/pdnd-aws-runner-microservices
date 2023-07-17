bucket         = "pdnd-tf-state"
key            = "prod/eu-central-1/serving-layer/pdnd-aws-runner-microservices/terraform.tfstate"
region         = "eu-central-1"
encrypt        = true
dynamodb_table = "lock-table"