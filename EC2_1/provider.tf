provider "aws" {
  region = "${var.region}"
  access_key = var.access_key
  secret_key = var.secret_key
  //version = "u can provide explicit version, in this example i used latest version, so i didnt mention the version"
}