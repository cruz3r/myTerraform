# AWS - Terraform

Environment Variables are used to pass the credentials
Windows

Name | Value
---|---|---
$env:AWS_ACCESS_KEY_ID = | "AccessKeyID"
$env:AWS_SECRET_ACCESS_KEY =|"AccessSecretKey"

Variables are made up of 3 parts

- Description = "some description"
- type = "string","list", or "map"
- default = (if no var is passed then will use default)

Passing a Variable:
terraform plan -var server_port="8090"

Output Variables
output "Name" {
    value = "${aws_instance.example.public_ip}"
}
How did I get Public_IP? It is an **Attribute Reference** and can be found in the provider documentation. <https://www.terraform.io/docs/providers/aws/d/instance.html>

calling outpus after "terraform apply"

- terraform output public_ip

Looking over chapter 2 I found that copying a single deployment to a cluster doesn't work well. There property names that change which cause confusion. Most can be found by looking closely at what is in the book, and looking at the errors in the planning stage.