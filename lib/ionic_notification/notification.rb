module IonicNotification
  class Notification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production

    def initialize(options = {})
      @tokens = init_tokens(options[:tokens])
      @title ||= options[:title] || default_title
      @message ||= options[:message] || default_message
      @android_payload ||= options[:android_payload] || {}
      @ios_payload ||= options[:ios_payload] || {}
      @production ||= options[:production] || init_production
    end

    def notify!
      self.class.post("/api/v1/push", payload)
    end

    def alert!(msg)
      notify do
        {
          alert: msg
        }
      end
    end

    def notify(&block)
      @message =  yield(block)
      notify!
    end

    def payload
      options = {}
      options.merge!(body: body).merge!({ basic_auth: auth}).merge!({ headers: headers})
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
