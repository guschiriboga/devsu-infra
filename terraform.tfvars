#Project
project_name = "iap-tmp"

#AWS
region = "us-west-2"

#Networking
cidr_info = {
  vpc            = "10.77.0.0/16"
  private_subnet = ["10.77.1.0/24", "10.77.2.0/24"]
  public_subnet  = ["10.77.3.0/24", "10.77.4.0/24"]
}

repos_info = {
  backend = "java-demo"
  infra   = "infra-demo"
}