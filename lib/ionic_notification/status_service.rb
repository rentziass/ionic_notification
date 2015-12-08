module IonicNotification
  class StatusService
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :body

    def initialize(message_id)
      @message_id = message_id
    end

    def check_status!
      self.class.post("/api/v1/status/#{@message_id}", payload)
    end

    def payload
      options = {}
      options.
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
