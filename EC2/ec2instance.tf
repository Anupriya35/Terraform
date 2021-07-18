provider "aws" {
  region ="ap-south-1"
  access_key ="access key"
  secret_key ="secret key"
  version ="~>15.3"

}
resource "aws_instance" "myec2"{
    ami = "ami-030caf8056c33d18a"
    instance_type = "t2.micro"
}