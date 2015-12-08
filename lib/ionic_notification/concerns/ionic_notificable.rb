module IonicNotification
  module Concerns
    module IonicNotificable
      extend ActiveSupport::Concern

      included do
        serialize :device_tokens, Array

        def notify(options = {})
          return new_logger.missing_device_tokens unless respond_to?(:device_tokens)
          return new_logger.no_device_tokens(self) unless device_tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: device_tokens))
          notification.send
        end

        def self.notify_all(options = {})
          return new_logger.missing_device_tokens unless method_defined?(:device_tokens)
          tokens = all.map(&:device_tokens).flatten.uniq
          return new_logger.no_device_tokens(self) unless tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: tokens))
          notification.send
        end

        private

        def new_logger
          IonicNotification::Logger.new
        end
      end
    end
  end
end
