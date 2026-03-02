locals {
  app_fqdn = "${var.app_subdomain}.${var.base_domain}"

  ses_subdomain      = trimsuffix(var.ses_domain, ".${var.base_domain}")
  ses_domain_suffix  = local.ses_subdomain != "" ? ".${local.ses_subdomain}" : ""
  mail_from_domain   = "bounce.${var.ses_domain}"
  mail_from_subdomain = trimsuffix(local.mail_from_domain, ".${var.base_domain}")
}

resource "cloudflare_record" "app" {
  zone_id         = var.cloudflare_zone_id
  name            = var.app_subdomain
  type            = "A"
  value           = var.dokku_server_ip
  ttl             = var.dns_ttl
  proxied         = false
  allow_overwrite = true
}

resource "aws_ses_domain_identity" "ses" {
  domain = var.ses_domain
}

resource "aws_ses_domain_dkim" "ses" {
  domain = aws_ses_domain_identity.ses.domain
}

resource "aws_ses_domain_mail_from" "ses" {
  domain             = aws_ses_domain_identity.ses.domain
  mail_from_domain   = local.mail_from_domain
  behavior_on_mx_failure = "UseDefaultValue"
}

resource "cloudflare_record" "ses_verification" {
  zone_id         = var.cloudflare_zone_id
  name            = "_amazonses${local.ses_domain_suffix}"
  type            = "TXT"
  value           = aws_ses_domain_identity.ses.verification_token
  ttl             = var.dns_ttl
  allow_overwrite = true
}

resource "cloudflare_record" "ses_dkim" {
  for_each = toset(aws_ses_domain_dkim.ses.dkim_tokens)

  zone_id         = var.cloudflare_zone_id
  name            = "${each.value}._domainkey${local.ses_domain_suffix}"
  type            = "CNAME"
  value           = "${each.value}.dkim.amazonses.com"
  ttl             = var.dns_ttl
  allow_overwrite = true
}

resource "cloudflare_record" "ses_mail_from_mx" {
  zone_id         = var.cloudflare_zone_id
  name            = local.mail_from_subdomain
  type            = "MX"
  value           = "feedback-smtp.${var.aws_region}.amazonses.com"
  priority        = 10
  ttl             = var.dns_ttl
  allow_overwrite = true
}

resource "cloudflare_record" "ses_mail_from_spf" {
  zone_id         = var.cloudflare_zone_id
  name            = local.mail_from_subdomain
  type            = "TXT"
  value           = "v=spf1 include:amazonses.com ~all"
  ttl             = var.dns_ttl
  allow_overwrite = true
}

resource "cloudflare_record" "ses_dmarc" {
  zone_id         = var.cloudflare_zone_id
  name            = "_dmarc${local.ses_domain_suffix}"
  type            = "TXT"
  value           = "v=DMARC1; p=none; rua=mailto:dmarc@${var.base_domain}; fo=1"
  ttl             = var.dns_ttl
  allow_overwrite = true
}

data "aws_iam_policy_document" "ses_smtp" {
  statement {
    sid     = "AllowSesSending"
    effect  = "Allow"
    actions = ["ses:SendRawEmail", "ses:SendEmail"]
    resources = [
      aws_ses_domain_identity.ses.arn
    ]
  }
}

resource "aws_iam_user" "ses_smtp" {
  name = "${var.project_name}-ses-smtp"
}

resource "aws_iam_user_policy" "ses_smtp" {
  name   = "${var.project_name}-ses-smtp"
  user   = aws_iam_user.ses_smtp.name
  policy = data.aws_iam_policy_document.ses_smtp.json
}

resource "aws_iam_access_key" "ses_smtp" {
  user = aws_iam_user.ses_smtp.name
}
