module IonicNotification
  class StatusService
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :body

    def initialize(message_uuid)
      @message_uuid = message_uuid
    end

    def check_status!
      self.class.get("/push/notifications/#{@message_uuid}", payload)
    end

    def check_messages_status!
      self.class.get("/push/notifications/#{@message_uuid}/messages", payload)
    end

    def payload
      options = {}
      options.
        merge!(headers: headers)
    end

    private

    def headers
      { 'Content-Type' => 'application/json', 'Authorization' => IonicNotification.ionic_application_api_token }
    end
  end
end
