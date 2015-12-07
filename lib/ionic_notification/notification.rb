module IonicNotification
  class Notification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production

    def initialize(options = {})
      @tokens = init_tokens(options[:tokens])
      @title ||= options[:title] || default_title
      @message ||= options[:message] || default_message

      if options[:android_payload]
        @android_payload ||= assign_payload(options[:android_payload])
      end

      if options[:ios_payload]
        @ios_payload ||= assign_payload(options[:ios_payload])
      end

      if options[:payload]
        @android_payload ||= assign_payload(options[:payload])
        @ios_payload ||= assign_payload(options[:payload])
      end

      @android_payload ||= default_payload
      @ios_payload ||= default_payload

      @production ||= options[:production] || init_production
    end

    def send
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
      IonicNotification.ionic_app_in_production
    end

    def assign_payload(payload)
      return default_payload unless payload
      return { payload: payload } if payload.is_a? Hash
      raise IonicNotification::WrongPayloadType.new(payload.class)
    end

    def body
      {
        tokens: @device_tokens,
        notification: @message
      }.to_json
    end
  end
end
