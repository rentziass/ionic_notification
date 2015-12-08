module IonicNotification
  module Concerns
    module IonicNotificable
      extend ActiveSupport::Concern

      included do
        serialize :device_tokens, Array

        def notify(options = {})
          return missing_device_tokens_logger unless respond_to?(:device_tokens)
          return no_device_tokens_logger unless device_tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: device_tokens))
          notification.send
        end

        private

        def no_device_tokens_logger
          logger.debug "#{logger_label} No device tokens were found for #{self}, skipping."
        end

        def missing_device_tokens_logger
          logger.debug "#{logger_label} This model does not respond to :device_tokens, did you run your migrations?"
        end

        def logger_label
          "IonicNotification:"
        end
      end
    end
  end
end
