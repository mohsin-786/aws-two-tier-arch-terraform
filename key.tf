resource "aws_key_pair" "key" {
  key_name   = "sin"
  public_key = file(your key)
}
