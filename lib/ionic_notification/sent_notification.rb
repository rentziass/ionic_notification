module IonicNotification
  class SentNotification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production, :result, :message_uuid, :sent_at, :profile

    def initialize(options = {})
      @tokens = options[:tokens]
      @title = options[:title]
      @message = options[:message]
      @profile = options[:profile]
      @android_payload = options[:android_payload]
      @ios_payload = options[:ios_payload]
      @production = options[:production]
      @result = options[:result]
      @message_uuid = options[:message_uuid]
      @sent_at = Time.now
      @scheduled = init_scheduled(options[:scheduled])
    end

    def status
      service = StatusService.new @message_uuid
      service.check_status!
    end

    def messages_status
      service = StatusService.new @message_uuid
      service.check_messages_status!
    end

    private

    def init_scheduled(timestamp)
      return DateTime.strptime(timestamp.to_s,'%s') if timestamp
    end
  end
end
