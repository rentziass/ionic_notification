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

  # ==> Configuration for the location of the API
  # Refer to the Ionic documentation for the correct location
  # Current documentation can be found here:
  # http://docs.ionic.io/docs/push-sending-push and
  # defaults to https://push.ionic.io
  # config.ionic_api_url = ENV["IONIC_API_URL"]
end
