module IonicNotification
  class SentNotification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production, :result, :message_id

    def initialize(options = {})
      @tokens = options[:tokens]
      @title = options[:title]
      @message = options[:message]
      @android_payload = options[:android_payload]
      @ios_payload = options[:ios_payload]
      @production = options[:production]
      @result = options[:result]
      @message_id = options[:message_id]
    end

    def status
      service = PushService.new body
      service.notify!
    end
  end
end
