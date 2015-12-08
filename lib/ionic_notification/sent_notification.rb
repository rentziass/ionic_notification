module IonicNotification
  class SentNotification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production, :result, :message_id, :sent_at

    def initialize(options = {})
      @tokens = options[:tokens]
      @title = options[:title]
      @message = options[:message]
      @android_payload = options[:android_payload]
      @ios_payload = options[:ios_payload]
      @production = options[:production]
      @result = options[:result]
      @message_id = options[:message_id]
      @sent_at = Time.now
    end

    def status
      service = StatusService.new @message_id
      service.check_status!
    end
  end
end
