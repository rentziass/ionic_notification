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
  config.ionic_application_api_token = ENV["IONIC_APPLICATION_API_TOKEN"]

  # Your Ionic app name will be used for the notification
  # title if none is provided. If you leave this undefined
  # IonicNotification will use your Rails app name
  config.ionic_app_name = Rails.application.class.parent_name

  # If you want, you can customize IonicNotification logging level
  # It defaults to :debug
  # config.log_level = :debug
  #
  # You can change the amount of stored sent notifications
  # config.notification_store_limit = 3
  #
  # By default, notifications with no message provided will be skipped,
  # you don't want your clients to receive a notification with no message,
  # right? Well, sometimes it can be useful to speed up development
  # and test. You could like to be able to do something like:
  #   User.first.notify
  # and see what happens, without bothering writing a fake message.
  # You can enable this if you want:
  # config.process_empty_messages = true
  # Or in a more safe way:
  # config.process_empty_messages = !Rails.env.production?
  #
  # Anyway, you can set up a default message to be used when you don't
  # provide one:
  # config.default_message = "This was intended to be a beautiful notification. Unfortunately, you're not qualified to read it."

  # If production is set to true, notifications will be sent
  # to all devices which have your app running with production
  # certificates (generally coming from store). Otherwise,
  # if set to false, to all devices which have your app running
  # with developer certificates.
  config.ionic_app_in_production = true

  # NEEDS DOCUMENTATION
  config.production_profile_tag = ENV["IONIC_APP_PRODUCTION_PROFILE"]
  config.development_profile_tag = ENV["IONIC_APP_DEVELOPMENT_PROFILE"]
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
