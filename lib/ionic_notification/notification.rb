module IonicNotification
  class Notification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production

    def initialize(options = {})
      @tokens = init_tokens(options[:tokens])
      @title ||= options[:title] || default_title
      @message ||= options[:message] || default_message
      @android_payload ||= options[:android_payload] || default_payload
      @ios_payload ||= options[:ios_payload] || default_payload
      @production ||= options[:production] || init_production
    end

    private

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
      {payload: {}}
    end

    def init_production
      IonicNotification.ionic_app_in_production
    end

    def body
      {
        tokens: @device_tokens,
        notification: @message
      }.to_json
    end
  end
end
