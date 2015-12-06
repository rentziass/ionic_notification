require 'rails/generators'
require 'rails/generators/active_record'
require 'generators/ionic_notification/orm_helpers'

module IonicNotification
  module Generators
    class ModelGenerator < ActiveRecord::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      desc "Generates a migration for the given MODEL, adding :device_tokens column"

      def copy_migration
        migration_template "migration.rb", "db/migrate/add_ionic_notification_to#{table_name}.rb"
      end

      def inject_ionic_notification_content
        content = model_contents
        
        class_path = if namespaced?
          class_name.to_s.split("::")
        else
          [class_name]
        end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

        inject_into_class(model_path, class_path.last, content)
      end
    end
  end
end
