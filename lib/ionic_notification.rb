require 'rails'
require 'httparty'

module IonicNotification
  # Registered application if for the ionic platform
  mattr_accessor :ionic_application_id
  @@ionic_application_id = ""

  # Private key for sending information
  mattr_accessor :ionic_api_key
  @@ionic_api_key = ""

  # API URL
  mattr_accessor :ionic_api_url
  @@ionic_api_url = "https://push.ionic.io"

  def self.setup
    yield self
  end
end

require 'ionic_notification/push_service'
