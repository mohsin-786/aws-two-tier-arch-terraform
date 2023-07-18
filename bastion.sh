sudo apt update -y
sudo apt install awscli -y
#cloud-config
runcmd:
  - aws ec2 associate-address --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --allocation-id ${aws_eip.eip-bastion.id} --allow-reassociation