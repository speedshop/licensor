output "app_domain" {
  value       = local.app_fqdn
  description = "Application domain served by Dokku"
}

output "smtp_address" {
  value       = "email-smtp.${var.aws_region}.amazonaws.com"
  description = "SES SMTP hostname"
}

output "smtp_port" {
  value       = 587
  description = "SES SMTP port"
}

output "smtp_domain" {
  value       = var.ses_domain
  description = "SMTP HELO domain"
}

output "smtp_username" {
  value       = aws_iam_access_key.ses_smtp.id
  description = "SES SMTP username (IAM access key id)"
}

output "smtp_password" {
  value       = aws_iam_access_key.ses_smtp.ses_smtp_password_v4
  description = "SES SMTP password"
  sensitive   = true
}

output "dokku_config_set_command" {
  value = join(" ", [
    "dokku config:set --no-restart licensor",
    "ACTION_MAILER_DELIVERY_METHOD=smtp",
    "SMTP_ADDRESS=email-smtp.${var.aws_region}.amazonaws.com",
    "SMTP_PORT=587",
    "SMTP_USERNAME=${aws_iam_access_key.ses_smtp.id}",
    "SMTP_PASSWORD=<use terraform output smtp_password>",
    "SMTP_DOMAIN=${var.ses_domain}",
    "SMTP_AUTHENTICATION=plain",
    "SMTP_ENABLE_STARTTLS_AUTO=true"
  ])
  description = "Command template for setting Dokku SMTP config"
}
