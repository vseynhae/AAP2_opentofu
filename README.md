# OpenTofu + Ansible Demo

This repository is based on https://github.com/RedHatBelux/AAP2_terraform and was created for the [CfgMgmtCamp 2026](https://cfgmgmtcamp.org/ghent2026/)

Slides are available in the [WIP](xxx)

## Intro

Configuration files and examples used for demonstrating OpenTofu and Ansible Automation Platform (AAP) integrations. 

Initially we will demonstrate OpenTofu and Ansible, individually from the CLI (folders `ansible-cli` and `opentofu-cli`).

This will bring up some challenges around the shared management of:

- credentials (AWS, SSH)
- Ansible inventory
- opentofu state file

We will integrate both technologies inside AAP:

- Running the OpenTofu code individually inside AAP
- Include the OpenTofu code as part of a larger workflow (day 1 + day 2)
- An approval will be requested to perform the opentofu apply
- AAP will manage the OpenTofu State file in an S3 bucket
- We'll use the OpenTofu State file as a dynamic inventory in order to post configure EC2 instances

## Requirements

- an AWS account with sufficient permissions
- an AAP 2.6 with admin rights
- the `cloud.terraform` collection with OpenTofu support [^1]
- an Ansible Execution Environment that contains the `cloud.terraform` Ansible Collection and the `opentofu` binary (prebuilt for the demo and available at `quay.io/redhatbelux/ee_opentofu`)[^2]
- `botocore` & `boto3` python libraries are needed on the machine used to stand up the demo environment.

## Preparing your AAP and AWS environments

In the `build_demo` folder:

- create a `vault-password.txt` file containing the password to decrypt your `vault.yml` file

	```bash
	echo "my_vault_passwd" > vault-password.txt
	```

- create your own `vault.yml` file, with the following structure:

	```bash
	ansible-vault create vault.yml
	```

	```yaml
	aap2_host: your-aap-hostname
	aap2_username: admin
	aap2_password: your-aap-admin-password
	
	aws_access: your-aws-access
	aws_secret: your-aws-secret
	aws_region: eu-central-1
	
	# no special characters in the name. Must be unique within AWS tenant.
	aws_bucket_name: yourbucket
	
	ssh_public_key: "ssh-rsa XYZ"
	
	ssh_private_key: |
	    -----BEGIN OPENSSH PRIVATE KEY-----
	    YOUR SSH PRIVATE KEY HERE
	    -----END OPENSSH PRIVATE KEY-----
	```

- Run `ansible-playbook 00-prepare.yml`.

This will create all the AAP resources:

- organization
- execution environment
- project
- credentials
  - to access AWS
  - to store the OpenTofu state file in an S3 bucket
  - the SSH credential to connect to the EC2 instances 
- some jobs
- a workflow that plugs those jobs

Some AWS resources: 

- a key pair that will be used by AAP to post provision EC2 instances
- an S3 bucket that will be used to store the OpenTofu State file

## When AAP is up and running

Under Automation Execution > Templates, run the workflow.

It will create a CentOS Stream 9 EC2 instances with OpenTofu.

When the OpenTofu run is done, the state file is stored in the S3 bucket.

The workflow will refresh the inventory (based on the state file).

The next job will deploy and configure Apache on the instances found in the OpenTofu state file.

[^1]: The `cloud.terraform` collection including OpenTofu support can be found [here](https://github.com/vseynhae/cloud.terraform)
[^2]: Code to build `ee_opentofu` image can be found [here](https://github.com/RedHatBelux/ee_opentofu)
