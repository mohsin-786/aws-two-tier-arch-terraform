
# Project Title

This is a Terraform project that deploys a web-server(EC2) and a database(RDS) on AWS. The web-server is deployed with Auto-Scaling Group (For HIgh Availabilty) on private subnets which has a Load Balancer. The databases are also deployed on private subnets.


# Prequisite

Install Terraform according to your system.

## Deployment

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

## To connect to Bastion Host and Instances in Private subnets

Do the following:

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
