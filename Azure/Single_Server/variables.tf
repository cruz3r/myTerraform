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
  description = "SSH Key for Azure in envvar"
  type = "string"
 }
