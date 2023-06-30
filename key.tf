resource "aws_key_pair" "key" {
  key_name   = "sin"
  public_key = file("~/.ssh/sin.pub")
}
