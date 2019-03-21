variable "server_port" {
  description = "Ingress Port information"
  type = "string"
  default = "8080"
}

variable "name" {
  description = "Prefix Name"
  type = "string"
  default = "Terraform"
 }
variable "count_id" {
  description = "Post Number Counter"
  type = "string"
  default = "00"
 }

 variable "user_name" {
   description = "Admin User Name"
   type = "string"
   default = "myUser"
 }

 variable "ssh_pub_key" {
  description = "SSH Key for Azure "
  type = "string"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxCz9HpWkByANJvNHgSlLadrOOl+U3+4yZ3sP68mMz+rpMYhRM5fV0EF6MeOvc0X01rsbQFRaHJGfTTCjQK5b0dZVCKCrTD/6RPrfF3CwR3XjRCxF3ZxlCJUGZtPNL97WaYjfe1U/9iVvqpB+wSuCFPUbNMaaIe5OQqfwJ63S0ppHBBU4PNrZIxj+Qh6eH56K2rZxsVLm0v9C9v3JBumR/KjPuu6Sa9dr7No/5TO+Ay8xPPz9pJVbUtj4kvkw+eKXlbG1Hl7wPbELtJ82ccIBrlENjWHYdDNNO63KSfoboLoMzPNId0S/y5OViVJLbBgG5S1PpjG8+GIItjok16K+Z qsadmin"
 }
