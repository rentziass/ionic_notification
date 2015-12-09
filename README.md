# IonicNotification

- [Getting started](#getting-started)
- [Model setup](#model-setup)
- [Sending a Push Notification](#sending-a-push-notification)
- [Check notification status](#check-notification-status)
- [Notification parameters](#notification-parameters)
- [Manually send a notification](#manually-send-a-notification)
- [Configuration](#configuration)

IonicNotification is an interface for Rails to use [Ionic.io](http://ionic.io/)'s [Push Notification](http://docs.ionic.io/docs/push-overview) service.

_Keep in mind that Ionic.io's Push Notification is still in alpha at the moment, so this gem will probably undergo some major updates in the near future._

## Getting started

```
gem install ionic_notification
```

You can add IonicNotification to your Gemfile with:

```
gem 'ionic_notification'
```

After you installed IonicNotification, you need to run the generator:

```
rails g ionic_notification:install
```

Configure the ionic_notification.rb file within config/initializers. You can use the default set environment variables, change them or hardcode those values (altough is highly NOT recommended)

```Ruby
  IonicNotification.setup do |config|
    
    config.ionic_application_id = ENV["IONIC_APPLICATION_ID"]
    config.ionic_api_key = ENV["IONIC_API_KEY"]

    config.ionic_app_name = "YourAppName"

    # ==> Configuration for the location of the API
    # Refer to the Ionic documentation for the correct location
    # Current documentation can be found here:
    # http://docs.ionic.io/docs/push-sending-push and
    # defaults to https://push.ionic.io
    # config.ionic_api_url = ENV["IONIC_API_URL"]
  end
```

## Model setup
You can use IonicNotification directly from models.
Run the proper generator:
```
rails g ionic_notification:model YOUR_MODEL
```
This creates a migration that will add a `:device_tokens` column to your model
```Ruby
class AddDeviceTokensTo_YOUR_MODEL < ActiveRecord::Migration
  def self.up
    add_column :your_model_table_name, :device_tokens, :text
  end

  def down
    remove_column :your_model_table_name, :device_tokens
  end
end
```

and includes IonicNotification in your model
```Ruby
# app/models/your_model.rb
class YourModel < ActiveRecord::Base
  # Include IonicNotification behaviour
  include IonicNotification::Concerns::IonicNotificable

  # Your stuff...
end
```

## Sending a Push Notification

```Ruby
# Assuming you want to send a notification to a User (yeah, weird, right?)
user = User.first
user.notify message: "Your super awesome notification message!"
```
This will simply send a notification with the provided message to all device tokens found on user.

You can also schedule notifications to be sent later, specifying either a DateTime or a delay.
```Ruby
user = User.first
user.notify_at Date.tomorrow, message: "I'm a scheduled notification"
user.notify_in 2.hours, message: "I'm a delayed one instead"
```

If you have to send the same notification to a collection of, say, users, you have `:notify_all`available for use.
```Ruby
User.where(something: true).notify_all message: "Spread the word!"
```

If you want to learn more about all the parameters a notification accepts, please refer to the [notification parameters](#notification-parameters) section.

## Check notification status
IonicNotification stores your last sent notifications (`3` by default), so that you check their status later.
You access them by calling
```Ruby
IonicNotification.latest_notifications
```
which returns an array of `IonicNotification::SentNotification`s, a representation of the notifications you built before.

On each of those you can call the `:status` method, and it will fetch the notification status from Ionic API.
```Ruby
# If you want to know what happened to your lost notification,
# or if you're simply curious about its status
notification = IonicNotification.latest_notifications.first
notification.status
```

## Notification parameters
- `:tokens`: The device tokens, the targets for your notifications. It accepts an Array or a String.
- `message`: The awesome message you want to display through your notification.
- `schedule`: Pass a DateTime to schedule your notification. You can use `:notify_at` and `:notify_in` methods to do this.
- `payload`: You can pass a Hash here to define a common payload for both iOS and Android.
- `ios_payload`: You can pass a Hash to specify a payload for iOS devices.
- `android_payload`: You can pass a Hash to specify a payload for Android devices.
- `production`: You can override `IonicNotification.ionic_app_in_production` for each of your notifications. Take a look at the [configuration](#configuration) section for further details.
- `:title`: See the `ionic_app_name` in the [configuration](#configuration) section for further details.

## Manually send a notification
In some cases, you may want to manually instantiate and send notifications. You can:
```Ruby
notification = IonicNotification::Notification.new(
  tokens: ["array", "of", "tokens"],
  message: "Your message"
) # You can pass any of the parameters of course.
notification.send
```

## Configuration
Here you'll find all required and optional options
#### `ionic_application_id`
> **_required_**

This is, wait for it, your Ionic application id, should be something like `"258d401f"`

#### `ionic_api_key`
> **_required_**

This must equal your Ionic API key, should be a pretty long string.

#### `ionic_app_name`
`ionic_app_name` will be used as the default title for your notifications, though in most cases on devices you will see the name of the installed app.
It defaults to `Rails.application.class.parent_name`.

#### `ionic_app_in_production`
If `ionic_app_in_production` is set to true, notifications will be sent to all devices which have your Ionic app running with production certificates (a.k.a apps generally coming from store). Otherwise, if set to false, they'll be sent to all devices which have your app running with developer certificates.
While it is set to `true` by default, if you want a more flexible solution set it to `Rails.env.production?`, so that notifications will be sent to "production devices" only while Rails app is running in production environment.

#### `log_level`
Defaults to `:debug`, customize it according to your needs. Available log levels are Rails standards: `:debug`, `:info`, `:warning`, `:fatal`, `:unknown`.

#### `notification_store_limit`
IonicNotification stores your last `3` sent notifications, unless you specify otherwise. As they're kept in memory, I seriously advise not to go nuts on this parameter setting it `trillions of trillions`. :neckbeard:

#### `process_empty_messages`
By default, notifications with no message provided will be skipped, you don't want your clients to receive a notification with no message, right? Well, sometimes it can be useful to speed up development and tests. You could like to be able to do something like this, from time to time:
```Ruby
User.first.notify
```
and see what happens, without bothering writing a fake message. You can enable this, if you want, setting `process_empty_messages` to `true`, or do it in a more safe way: `!Rails.env.production?`.

#### `default_message`
If you're allowing IonicNotification to process empty messages (see above), you'll want to set a default message.

#### `ionic_api_url`
Refer to [Ionic documentation](http://docs.ionic.io/docs/push-sending-push) for further information. It defaults to the standard Ionic endpoints.

## License

This project uses MIT-LICENSE.
This project started from the codebase of [nwwatson _ionic_push_repo_](https://github.com/nwwatson/ionic_push)
