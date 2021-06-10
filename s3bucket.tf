provider "aws" {
  region = "eu-west-1"
  profile = "anu-terraform"
}
resource "aws_s3_bucket" "mybucket" {
  bucket = "myterraform-s3-bucket-2021"
  acl    = "private"
  

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "myfirstobject" {
  bucket = "${aws_s3_bucket.mybucket.id}"
  key    = "testfile.txt"
  source = "../testfiles/sampleobject.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../testfiles/sampleobject.txt")
}