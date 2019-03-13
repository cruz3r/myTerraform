variable "server_port" {
  description = "Ingress Port information"
  type = "string"
  default = "8080"
}

output "public_ip" {
  value = "http://${aws_instance.example.public_ip}:${var.server_port}"
}