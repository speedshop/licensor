# Heroku → Dokku Migration Plan (Terraform-managed)

## Goals

- Move `licensor` from Heroku to Dokku on `5.161.236.236`
- Keep downtime within **5–10 minutes**
- Migrate Postgres data
- Keep existing domain: `rpw-licensor.speedshop.co`
- Replace Mailgun with AWS SES (Cloudflare-managed DNS)
- Manage infra changes with Terraform

---

## Current app notes

- App process: `web: bundle exec puma -p ${PORT:-3000}`
- App is already Dokku-friendly (`app.json` has `postdeploy` migration hook)
- Mailer config was Mailgun-specific; now migrated to provider-agnostic SMTP (with optional Mailgun fallback)

---

## High-level migration approach

1. **Prepare Dokku target** (no traffic yet)
2. **Provision DNS + SES with Terraform**
3. **Deploy app to Dokku and validate**
4. **Rehearse DB migration**
5. **Cut over with short maintenance window**
6. **Observe + rollback-ready window**

---

## Phase 1: Terraform baseline

Create Terraform project under `infra/terraform` with:

- Cloudflare provider
- AWS provider (SES + SMTP IAM creds)
- DNS records for:
  - app traffic: `rpw-licensor.speedshop.co -> 5.161.236.236`
  - SES verification + DKIM/SPF/DMARC for sender domain

### Suggested variables

- `cloudflare_api_token`
- `cloudflare_zone_id`
- `dokku_server_ip` (default `5.161.236.236`)
- `app_subdomain` (default `rpw-licensor`)
- `base_domain` (default `speedshop.co`)
- `ses_domain` (default `mg.speedshop.co`)
- `aws_region` (default `us-east-1`)

---

## Phase 2: Dokku app prep

On Dokku server:

1. Install Dokku + plugins:
   - `postgres`
   - `letsencrypt`
2. Create app + DB and link DB:
   - `dokku apps:create licensor`
   - `dokku postgres:create licensor-db`
   - `dokku postgres:link licensor-db licensor`
3. Set env vars (`dokku config:set --no-restart licensor ...`):
   - Rails app secrets
   - Stripe/Zapier/S3 keys
   - SMTP settings from Terraform outputs (SES)
4. Deploy app and run smoke checks on Dokku hostname first.

---

## Phase 3: SES migration

1. Create SES domain identity for `mg.speedshop.co`
2. Add SES verification/DKIM DNS records via Terraform (Cloudflare)
3. Create SMTP IAM user/access key and use `ses_smtp_password_v4`
4. Set Dokku env:
   - `ACTION_MAILER_DELIVERY_METHOD=smtp`
   - `SMTP_ADDRESS=email-smtp.<region>.amazonaws.com`
   - `SMTP_PORT=587`
   - `SMTP_USERNAME=<iam access key id>`
   - `SMTP_PASSWORD=<ses smtp password v4>`
   - `SMTP_DOMAIN=mg.speedshop.co`
5. Validate transactional emails from staging/preview deploy

---

## Phase 4: DB migration rehearsal (required)

Run this once before production cutover:

1. Capture Heroku backup: `heroku pg:backups:capture -a <app>`
2. Download backup URL
3. Restore into Dokku Postgres test DB
4. Deploy same app build and run migrations
5. Time full process; ensure it fits <10 min

If timing exceeds budget, plan a longer maintenance window.

---

## Phase 5: Production cutover runbook

### T-24h

- Lower DNS TTL for `rpw-licensor.speedshop.co` to 60

### T-30m

- Confirm Dokku app healthy
- Confirm SES verified and sending
- Confirm rollback command ready

### T-5m

- Enable Heroku maintenance mode:
  - `heroku maintenance:on -a <app>`

### T-4m

- Capture fresh Heroku DB backup
- Restore to Dokku Postgres
- Run `rails db:migrate`

### T+0

- Apply Terraform to switch DNS `A` record to `5.161.236.236`
- Verify HTTPS + app health + core flows

### T+15m

- Watch logs/errors
- Keep Heroku as rollback standby

### T+24-72h

- If stable, decommission Heroku resources

---

## Rollback

If critical issue after cutover:

1. Point DNS back to Heroku target via Terraform
2. Disable Heroku maintenance mode
3. Investigate Dokku issue and retry later

Keep Heroku resources until Dokku is stable for at least 24 hours.

---

## Implementation status

- [x] App mailer config moved from Mailgun-only to SMTP-first (SES-ready)
- [x] App env contract updated to SMTP variables in `app.json`
- [x] Terraform SES + Cloudflare resources (`infra/terraform`)
- [ ] Dokku bootstrap automation
- [ ] Cutover checklist script/commands
