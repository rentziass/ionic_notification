module IonicNotification
  class PushService
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :body

    def initialize(body)
      @body = body
    end

    def notify!
      self.class.post("/api/v1/push", payload)
    end

    def payload
      options = {}
      puts @body
      options.merge!(body: @body).
        merge!(basic_auth: auth).
        merge!(headers: headers)
    end

    private

    def auth
      { username: IonicNotification.ionic_api_key }
    end

    def headers
      { 'Content-Type' => 'application/json', 'X-Ionic-Application-Id' => IonicNotification.ionic_application_id }
    end
  end
end
