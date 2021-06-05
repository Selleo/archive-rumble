terraform {
  required_version = "0.15.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }

}

provider "aws" {
  region = var.region
}
