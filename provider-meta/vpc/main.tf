terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version  = "5.47.0"
      configuration_aliases = [aws.provider1, aws.provider2]
    }
  }
}
