
# :classical_building: Architecture
![](https://github.com/mohsin-786/aws-two-tier-arch-terraform/blob/main/aws2.gif)



# :scroll: Project Title

This is a Terraform project that deploys a web-server(EC2) and a database(RDS) on AWS. The web-server is deployed with Auto-Scaling Group (For HIgh Availabilty) on private subnets which has a Load Balancer. The databases are also deployed on private subnets.


# :hourglass: Prequisite

Install Terraform according to your system.

# :cloud: Deployment

To deploy this project run:

Firstly,

```bash
  terraform init
```
Secondly,

```bash
  terraform plan
```

And Finally,

```bash
  terraform apply
```


# :shield: Always remember the following when configuring your Bastion:

I have used Bastion host because it often sits on the Internet, they typically run a minimum amount of services in order to reduce their attack surface.
They are used to connect to private subnets.


a) Never place your SSH private keys on the bastion instance. Instead, use SSH agent forwarding to connect first to the bastion and from there to other instances in private subnets. This lets you keep your SSH private key just on your computer.

b) Configure the security group on the bastion to allow SSH connections (TCP/22) only from known and trusted IP addresses.

c) Configure Linux instances in your VPC to accept SSH connections only from bastion instances.

# :link: To connect to Bastion Host and Instances in Private subnets
Do the following to connect:

First generate keys if you dont have it:
```bash
  ssh-keygen -t rsa
```
This will save the keys to ~/.ssh folder in home directory



1. Run the ssh-agent
```bash
  ssh-agent <path to your shell>
```

2. Run ssh-add along with private key
```bash
  ssh-add <path to your private key>
```
3. To verify the keys available to ssh-agent use:
```bash
  ssh-add -L
```

4. Finally ssh into Bastion host.
```bash
  ssh -A user@<Bastion IP or DNS>
```

Once u get into the Bastion host, you can ssh into private subnets liek this:
```bash
  ssh user@<Instance IP>
```
