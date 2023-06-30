variable "ami" {
  default = "ami-0f5ee92e2d63afc18"
}
variable "type" {
  default = "t2.micro"
}
variable "pub-subnet" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "priv-subnet" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "az" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}