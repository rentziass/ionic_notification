module IonicNotification
  class PushService
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :body

    def initialize(notification)
      @notification = notification
    end

    def notify!
      resp = self.class.post("/api/v1/push", payload)
      IonicNotification.store(sent_notification(resp))
    end

    def payload
      options = {}
      options.merge!(body: body).
        merge!(basic_auth: auth).
        merge!(headers: headers)
    end

    private

    def sent_notification(resp)
      IonicNotification::SentNotification.new(
        tokens: @notification.tokens,
        production: @notification.production,
        title: @notification.title,
        message: @notification.message,
        android_payload: @notification.android_payload,
        ios_payload: @notification.ios_payload,
        scheduled: @notification.scheduled,
        result: resp["result"],
        message_id: resp["message_id"]
      )
    end

    def body
      {
        tokens: @notification.tokens,
        production: @notification.production,
        notification: {
          title: @notification.title,
          alert: @notification.message,
          android: @notification.android_payload,
          ios: @notification.ios_payload
        }
      }.to_json
    end

    def auth
      { username: IonicNotification.ionic_api_key }
    end

    def headers
      { 'Content-Type' => 'application/json', 'X-Ionic-Application-Id' => IonicNotification.ionic_application_id }
    end
  end
end
