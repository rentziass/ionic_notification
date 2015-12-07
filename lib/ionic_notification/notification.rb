module IonicNotification
  class Notification
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :tokens, :title, :message, :android_payload,
      :ios_payload, :production

    def initialize(options = {})
      @title ||= options[:title] || default_title
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

    def default_title
      IonicNotification.ionic_app_name
    end

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
