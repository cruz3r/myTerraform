output "storage_name" {
  value = "${aws_instance.example.arn}"
}

output "public_ip" {
  value = "http://${aws_instance.example.public_ip}:${var.server_port}"
}