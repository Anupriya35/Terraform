terraform {
  //required_version = ">= 0.11.0"
  backend "s3" {
    //access_key = "${var.access_key}"
    //secret_key = "${var.secret_key}"
    //[credentails has to be given explicitly sometimes]
    bucket = "terraform-bucket-anu"
    key    = "terraform/test"
    region = "us-east-1" // for nw S3 bucket
    dynamodb_table = "backend_test"
    //create the dynamoDb in the same region where tfstate - s3 (region)
  }
}