#EIP NAT-1 
resource "aws_eip" "eip-1" {
  domain = "vpc"
}
#EIP NAT-2
resource "aws_eip" "eip-2" {
  domain = "vpc"
}
#EIP FOR BASTION HOST
resource "aws_eip" "eip-bastion" {
  domain = "vpc"
}
