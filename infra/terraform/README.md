# Terraform: Dokku DNS + AWS SES

This Terraform project manages:

- Cloudflare DNS for `rpw-licensor.speedshop.co`
- AWS SES domain identity + DKIM + MAIL FROM records
- IAM SMTP credentials for SES

## Usage

```bash
cd infra/terraform
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with real values

terraform init
terraform plan
terraform apply
```

## Required variables

- `cloudflare_api_token`
- `cloudflare_zone_id`

Everything else has defaults aligned with this project.

## Important notes

- SES accounts may start in sandbox mode. Request production access before cutover.
- `smtp_password` is sensitive. Pull it with `terraform output -raw smtp_password` and store in your secret manager.
- Keep DNS `proxied = false` for Dokku cutover/TLS simplicity.
