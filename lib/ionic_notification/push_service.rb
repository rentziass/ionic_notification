module IonicNotification
  class PushService
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :body

    def initialize(notification)
      @notification = notification
    end

    def notify!
      resp = self.class.post("/push/notifications", payload)
      IonicNotification.store(sent_notification(resp))
    end

    def payload
      options = {}
      options.merge!(body: body).
        merge!(headers: headers)
    end

    private

    def sent_notification(resp)
      IonicNotification::SentNotification.new(
        tokens: @notification.tokens,
        production: @notification.production,
        title: @notification.title,
        message: @notification.message,
        profile: @notification.profile,
        android_payload: @notification.android_payload,
        ios_payload: @notification.ios_payload,
        scheduled: @notification.scheduled,
        result: resp["result"],
        message_uuid: resp["message_uuid"]
      )
    end

    def body
      body = {
        tokens: @notification.tokens,
        profile: @notification.profile,
        notification: {
          title: @notification.title,
          message: @notification.message,
          android: @notification.android_payload,
          ios: @notification.ios_payload
        }
      }

      body.merge!(scheduled: @notification.scheduled) if @notification.scheduled
      body.to_json
    end

    def headers
      { 'Content-Type' => 'application/json', 'Authorization' => IonicNotification.api_token_auth }
    end
  end
end
