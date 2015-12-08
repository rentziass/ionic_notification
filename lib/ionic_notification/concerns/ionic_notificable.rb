module IonicNotification
  module Concerns
    module IonicNotificable
      extend ActiveSupport::Concern

      included do
        serialize :device_tokens, Array

        def notify(options = {})
          logger = self.class.new_logger
          return logger.missing_device_tokens unless respond_to?(:device_tokens)
          tokens = device_tokens.uniq
          return logger.no_device_tokens(self) unless tokens.count > 0
          notification = IonicNotification::Notification.new(options.merge!(tokens: tokens))
          notification.send
        end

        def notify_at(schedule, options = {})
          options.merge!(scheduled: schedule.to_time.to_i)
          notify options
        end

        def notify_in(delay, options = {})
          schedule = Time.now + delay
          options.merge!(scheduled: schedule.to_i)
          notify options
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
