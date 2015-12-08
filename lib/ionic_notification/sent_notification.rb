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

    private

    def body
      {
        tokens: @tokens,
        production: @production,
        notification: {
          title: @title,
          alert: @message,
          android: @android_payload,
          ios: @ios_payload
        }
      }.to_json
    end

    def init_tokens(tokens)
      case tokens
      when Array
        tokens
      when String
        [tokens]
      else
        raise IonicNotification::WrongTokenType.new(tokens.class)
      end
    end

    def default_title
      IonicNotification.ionic_app_name
    end

    def default_message
      "Empty notification."
    end

    def default_payload
      { payload: {} }
    end

    def init_production
      IonicNotification.ionic_app_in_production || false
    end

    def assign_payload(payload)
      return default_payload unless payload
      return { payload: payload } if payload.is_a? Hash
      raise IonicNotification::WrongPayloadType.new(payload.class)
    end
  end
end
