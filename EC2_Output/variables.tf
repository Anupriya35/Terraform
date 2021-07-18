variable "region" {
  default = "ap-south-1"
}
variable "access_key" {}
variable "secret_key"{}

variable "private_key_path" {
  default = "terraform.pem"
}

variable "ami_id" {
  type =map

  default = {
    "ap-south-1"   = "ami-030caf8056c33d18a"
    "eu-west-2"    = "ami-132b3c7efe6sdfdsfd"
    "eu-central-1" = "ami-9787h5h6nsn"
  }
  
}