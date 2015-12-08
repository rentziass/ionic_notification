module IonicNotification
  class Logger
    def no_device_tokens_logger(instance)
      return unless available?
      ionic_logger "#{logger_label} No device tokens were found for #{instance}, skipping."
    end

    def missing_device_tokens_logger
      return unless available?
      ionic_logger "#{logger_label} This model does not respond to :device_tokens, did you run your migrations?"
    end

    def logger_label
      "IonicNotification:"
    end

    private

    def ionic_logger(message)
      Rails.logger.send(IonicNotification.log_level, message)
      nil
    end

    def available_log_levels
      [:debug, :info, :warn, :error, :fatal, :unknown]
    end

    def available?
      if available_log_levels.include? IonicNotification.log_level
        true
      else
        Rails.logger.fatal "#{logger_label} The specified log level is not available!"
        false
      end
    end
  end
end
