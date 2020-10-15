require 'securerandom'

class LicenseKey < ApplicationRecord
  def self.generate_key 
    SecureRandom.uuid
  end
end
