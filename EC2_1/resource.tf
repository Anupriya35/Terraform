resource "aws_instance" "myec2"{
    ami = "${lookup(var.ami_id, var.region)}"
    instance_type = "t2.micro"
}