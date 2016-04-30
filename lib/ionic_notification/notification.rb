module IonicNotification
  class Notification
    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production, :scheduled, :profile

    def initialize(options = {})
      @message_provided = options[:message]

      @tokens = init_tokens(options[:tokens])
      @title ||= options[:title] || default_title
      @message ||= options[:message] || default_message
      @profile ||= options[:profile] || default_profile_tag

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

      @scheduled = options[:scheduled]

      @production = options[:production] || init_production
    end

    def send
      if @message_provided || IonicNotification.process_empty_messages
        service = PushService.new self
        service.notify!
      else
        self.class.new_logger.empty_message
      end
    end

    private

    def self.new_logger
      IonicNotification::Logger.new
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
      IonicNotification.default_message
    end

    def default_profile_tag
      IonicNotification.default_profile_tag
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
