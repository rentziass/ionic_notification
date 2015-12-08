IonicNotification.setup do |config|
  # ==> Configuration for the Ionic.io Application ID
  # The Application ID can be found on the dashboard of
  # https://apps.ionic.io/apps
  config.ionic_application_id = ENV["IONIC_APPLICATION_ID"]

  # ==> Configuration for the Ionic API Key
  # The  API Key for your application can be found
  # within the Settings of your application on
  # https://apps.ionic.io/apps
  config.ionic_api_key = ENV["IONIC_API_KEY"]

  # Your Ionic app name will be used for the notification
  # title if none is provided. If you leave this undefined
  # IonicNotification will use your Rails app name
  config.ionic_app_name = "YourAppName"

  # If you want, you can customize IonicNotification logging level
  # It defaults to :debug
  # config.log_level = :debug

  # If production is set to true, notifications will be sent
  # to all devices which have your app running with production
  # certificates (generally coming from store). Otherwise,
  # if set to false, to all devices which have your app running
  # with developer certificates.
  config.ionic_app_in_production = true
  # If you want a more flexible solution, you can
  # uncomment this, so that notifications will be sent
  # to "production devices" only while Rails app is running
  # in production environment
  # config.ionic_app_in_production = Rails.env.production?

  # ==> Configuration for the location of the API
  # Refer to the Ionic documentation for the correct location
  # Current documentation can be found here:
  # http://docs.ionic.io/docs/push-sending-push and
  # defaults to https://push.ionic.io
  # config.ionic_api_url = ENV["IONIC_API_URL"]
end
