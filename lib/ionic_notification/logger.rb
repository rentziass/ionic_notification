module IonicNotification
  module Logger
    def no_device_tokens_logger
      available?
      ionic_logger "#{logger_label} No device tokens were found for #{self}, skipping."
    end

    def missing_device_tokens_logger
      available?
      ionic_logger "#{logger_label} This model does not respond to :device_tokens, did you run your migrations?"
    end

    def logger_label
      "IonicNotification:"
    end

    private

    def ionic_logger
      logger.send(IonicNotification.log_level)
    end

    def available_log_levels
      [:debug, :info, :warn, :error, :fatal, :unknown]
    end

    def available?
      unless available_log_levels.include? IonicNotification.log_level
        return logger.fatal "#{logger_label} The specified log level is not available!"
      end
    end
  end
end
