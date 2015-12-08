require 'rails'
require 'httparty'

module IonicNotification
  # Registered application if for the ionic platform
  mattr_accessor :ionic_application_id
  @@ionic_application_id = ""

  # Private key for sending information
  mattr_accessor :ionic_api_key
  @@ionic_api_key = ""

  # Application name
  mattr_accessor :ionic_app_name
  @@ionic_app_name = Rails.application.class.parent_name

  # Is application in production
  mattr_accessor :ionic_app_in_production
  @@ionic_app_in_production = true

  # Logging level
  mattr_accessor :log_level
  @@log_level = :debug

  # Array that stores latest X sent notifications
  mattr_accessor :latest_notifications
  @@latest_notifications = []

  # Array that stores latest X sent notifications
  mattr_accessor :notification_store_limit
  @@notification_store_limit = 10

  # API URL
  mattr_accessor :ionic_api_url
  @@ionic_api_url = "https://push.ionic.io"

  def self.setup
    yield self
  end

  def self.store(notification)
    if latest_notifications.count >= notification_store_limit
      latest_notifications.shift
    end
    latest_notifications << notification
  end
end

require "ionic_notification/logger"
require "ionic_notification/push_service"
require "ionic_notification/notification"
require "ionic_notification/exceptions"
require "ionic_notification/concerns/ionic_notificable"
