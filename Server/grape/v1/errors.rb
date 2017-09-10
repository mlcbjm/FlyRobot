module V1
  module Exceptions

    NOT_LOGIN = 1

    class NotLoginErrors < StandardError
      CODE = 1
    end # class NotLoginError

    class ClientVersionErrors < StandardError
      CODE = 2

      attr :config

      def initialize(config)
        @config = config
      end
    end # class ClientVersionErrors

  end # module Exceptions
end # module V1
