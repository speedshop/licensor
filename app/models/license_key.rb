require "securerandom"

class LicenseKey < ApplicationRecord
  enum product: [ :rpw, :sip ]

  def self.generate_key
    SecureRandom.uuid
  end
end
