module IonicNotification
  module Concerns
    module IonicNotificable
      extend ActiveSupport::Concern

      included do
        serialize :device_tokens, Array

        def notify(options = {})
          return missing_device_tokens_logger unless respond_to?(:device_tokens)
          return no_device_tokens_logger(self) unless device_tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: device_tokens))
          notification.send
        end

        def self.notify_all(options = {})
          return missing_device_tokens_logger unless method_defined?(:device_tokens)
          tokens = all.map(&:device_tokens).flatten.uniq
          return no_device_tokens_logger(self) unless tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: tokens))
          notification.send
        end
      end
    end
  end
end
