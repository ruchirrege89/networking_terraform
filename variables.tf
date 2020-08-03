variable "vpc_cidr" {
  description = "Choose cidr for vpc"
  type        = "string"
  default     = "10.20.0.0/16"
}

variable "region" {
  description = "Choose region for your stack"
  type        = "string"
  default     = "us-east-1"
}

variable "nat_amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-0ba960472fc891755"

  }
}
