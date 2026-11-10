variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "proyecto" {
  type    = string
  default = "terraform-lab"
}

variable "nombre_usuario" {
  description = "Nombre del usuario IAM que se creará"
  type        = string
  default     = "s3-app-user"
}