# Demostration of pass agruments in module using variable
module "module-example" {
  //source = "https://github.com/Anupriya35/terraform/tree/main/instance_template.git"
    source = "./instance_template"
    region                     = "${var.region}"
    ami_id                     = "${var.ami_id}"
    instance_type              = "${var.instance_type}"
    tag                        = "${var.tag}"

}

output "instance_public_ip_address"{
  value="${module.module-example.instance_ip}"
}