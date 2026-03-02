variable "aws_region" {
  description = "AWS region for SES"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project slug used in IAM naming"
  type        = string
  default     = "licensor"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token with Zone DNS edit permissions"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for speedshop.co"
  type        = string
}

variable "base_domain" {
  description = "Base DNS zone name"
  type        = string
  default     = "speedshop.co"
}

variable "app_subdomain" {
  description = "Application subdomain"
  type        = string
  default     = "rpw-licensor"
}

variable "dokku_server_ip" {
  description = "Public IP of the Dokku server"
  type        = string
  default     = "5.161.236.236"
}

variable "ses_domain" {
  description = "SES sending domain (must be inside base_domain)"
  type        = string
  default     = "mg.speedshop.co"
}

variable "dns_ttl" {
  description = "TTL for DNS records"
  type        = number
  default     = 60
}
