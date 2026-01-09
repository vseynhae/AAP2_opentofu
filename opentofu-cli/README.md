# OpenTofu CLI

OpenTofu code to deploy a basic infrastructure in AWS


## Preparing your environment


1. Install OpenTofu


    ```bash
    wget  "https://github.com/opentofu/opentofu/releases/download/v1.11.2/tofu_1.11.2_linux_amd64.zip" -O /tmp/tofu.zip
    unzip /tmp/tofu.zip -d /usr/local/bin/
    sudo unzip /tmp/tofu.zip -d /usr/local/bin/
    ```

1. Define your credentials as environment variables

	```
	export AWS_ACCESS_KEY_ID="redacted"
	export AWS_SECRET_ACCESS_KEY="redacted"
	```

## Deploy resources

1. Initialize OpenTofu

	`opentofu init`

1. Create OpenTofu's plan

	`opentofu plan -out=myplan.tfplan`

1. Deploy resources

	`opentofu apply myplan.tfplan`
