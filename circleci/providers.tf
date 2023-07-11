data "local_file" "cci_data" {
  filename = "./circleci_data.json"
}

terraform {
  required_providers {
    circleci = {
      source  = "mrolla/circleci"
      version = "0.6.1"
    }
  }
}

provider "circleci" {
  api_token    = jsondecode(data.local_file.cci_data.content).api-key
  vcs_type     = "github"
  organization = jsondecode(data.local_file.cci_data.content).organization
}
