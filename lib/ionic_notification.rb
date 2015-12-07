require 'rails'
require 'httparty'

module IonicNotification
  # Registered application if for the ionic platform
  mattr_accessor :ionic_application_id
  @@ionic_application_id = ""

  # Private key for sending information
  mattr_accessor :ionic_api_key
  @@ionic_api_key = ""

  # Private key for sending information
  mattr_accessor :ionic_app_name
  @@ionic_app_name = ""

  # API URL
  mattr_accessor :ionic_api_url
  @@ionic_api_url = "https://push.ionic.io"

  def self.setup
    yield self
  end
end

require 'ionic_notification/push_service'
require 'ionic_notification/notification'
require 'ionic_notification/concerns/ionic_notificable'
