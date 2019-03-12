variable "server_port" {
  description = "Ingress Port information"
  type = "string"
  default = "8080"
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}