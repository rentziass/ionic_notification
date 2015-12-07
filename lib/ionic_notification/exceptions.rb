module IonicNotification
  class WrongTokenType < StandardError
    def initialize(klazz= nil)
      return complete_message(klazz) if klazz
      default_message
    end

    private

    def default_message
      "Wrong type of tokens provided."
    end

    def complete_message(klazz)
      "Wrong type of tokens provided. String and Array are accepted, #{klazz} was given."
    end
  end
end
