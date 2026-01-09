# Ansible CLI

Ansible code to deploy and configure an Apache server


## Preparing your environment


1. Install Terraform

	```bash
	sudo yum install -y ansible-core
	```

1. Update the `private_key_file` variable in the `ansible.cfg` file

	```
	[defaults]
	inventory = inventory
	private_key_file = ~/.ssh/your_private_key
	remote_user = ec2-user
	host_key_checking = False
	```

## Deploy Apache

1. Run the ansible playbook

	`ansible-playbook apache.yml `
