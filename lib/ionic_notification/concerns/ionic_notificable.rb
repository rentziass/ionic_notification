module IonicNotification
  module Concerns
    module IonicNotificable
      extend ActiveSupport::Concern

      included do
        serialize :device_tokens, Array

        def notify(options = {})
          notification = IonicNotification::Notification.new(options.merge!(tokens: device_tokens))
          notification.send
        end
      end
    end
  end
end
