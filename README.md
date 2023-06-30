
# Project Title

This is a Terraform project that deploys a web-server(EC2) and a database(RDS) on AWS. The web-server is deployed with Auto-Scaling Group (For HIgh Availabilty) on public subnets which has a Load Balancer. The database are deployed on private subnets.


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

## Appendix

To destroy the entire Infrastructure

Run

```bash
  terraform destroy
```

