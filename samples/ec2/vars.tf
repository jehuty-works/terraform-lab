// initialize empty variables for keys, and assign with a secured *.auto.tfvars file
variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-06c8ff16263f3db59"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = ".ssh/lab-key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = ".ssh/lab-key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}