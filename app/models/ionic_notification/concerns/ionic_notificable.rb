module IonicNotification::Concerns::IonicNotificable
  extend ActiveSupport::Concern

  included do
    serialize :device_tokens, Array

    def notify
      puts "Fire notification"
    end
  end
end
