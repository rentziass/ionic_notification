module IonicNotification
  class Notification
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :tokens, :message, :android_payload

    def initialize(**args)
      #args.each &method(:instance_variable_set)
      args.each do |attr, value|
        instance_variable_set("@#{attr}", value)
      end
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

    def auth
      { username: IonicNotification.ionic_api_key }
    end

    def headers
      { 'Content-Type' => 'application/json', 'X-Ionic-Application-Id' => IonicNotification.ionic_application_id }
    end

    def body
      {
        tokens: @device_tokens,
        notification: @message
      }.to_json
    end
  end
end
