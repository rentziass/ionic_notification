module IonicNotification
  module Concerns
    module IonicNotificable
      extend ActiveSupport::Concern

      included do
        serialize :device_tokens, Array

        def notify(options = {})
          logger = self.class.new_logger
          return logger.missing_device_tokens unless respond_to?(:device_tokens)
          return logger.no_device_tokens(self) unless device_tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: device_tokens))
          notification.send
        end

        def self.notify_all(options = {})
          logger = new_logger
          return logger.missing_device_tokens unless method_defined?(:device_tokens)
          tokens = all.map(&:device_tokens).flatten.uniq
          return logger.no_device_tokens(self) unless tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: tokens))
          notification.send
        end

        private

        def self.new_logger
          IonicNotification::Logger.new
        end
      end
    end
  end
end
