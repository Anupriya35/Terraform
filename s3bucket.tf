provider "aws" {
  region = "eu-west-1"
  profile = "anu-terraform"
}
resource "aws_s3_bucket" "mybucket" {
  bucket = "myterraform-s3-bucket-2021"
  acl    = "private"
  

  tags = {
    Name        = "My bucket"
    Environment = "try"
  }
}

resource "aws_s3_bucket_object" "myfirstobject" {
  bucket = "${aws_s3_bucket.mybucket.id}"
  key    = "testfile.txt"
  source = "../testfiles/sampleobject.txt"

  etag = filemd5("../testfiles/sampleobject.txt")
}
