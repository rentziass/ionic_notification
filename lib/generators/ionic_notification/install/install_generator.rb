require 'rails/generators'

module IonicNotification
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      desc "Generates IonicNotification initializer"

      def copy_config
        copy_file "ionic_notification.rb", "config/initializers/ionic_notification.rb"
      end
    end
  end
end
