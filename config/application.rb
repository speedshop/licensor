require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Licensor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.action_mailer.delivery_method = ENV.fetch("ACTION_MAILER_DELIVERY_METHOD", "smtp").to_sym

    if config.action_mailer.delivery_method == :mailgun
      config.action_mailer.mailgun_settings = {
        api_key: ENV["MAILGUN_API_KEY"],
        domain: ENV.fetch("MAILGUN_DOMAIN", "mg.speedshop.co")
      }
    end

    if config.action_mailer.delivery_method == :smtp
      config.action_mailer.smtp_settings = {
        address: ENV["SMTP_ADDRESS"] || ENV["MAILGUN_SMTP_SERVER"] || "localhost",
        port: (ENV["SMTP_PORT"] || ENV["MAILGUN_SMTP_PORT"] || "587").to_i,
        user_name: ENV["SMTP_USERNAME"] || ENV["MAILGUN_SMTP_LOGIN"],
        password: ENV["SMTP_PASSWORD"] || ENV["MAILGUN_SMTP_PASSWORD"],
        domain: ENV["SMTP_DOMAIN"] || ENV["MAILGUN_DOMAIN"] || "mg.speedshop.co",
        authentication: ENV.fetch("SMTP_AUTHENTICATION", "plain").to_sym,
        enable_starttls_auto: ENV.fetch("SMTP_ENABLE_STARTTLS_AUTO", "true") == "true"
      }.compact
    end
  end
end
