module AccountComponent
  module Commands
    module Command
      def self.included(cls)
        cls.class_exec do
          include Messaging::Postgres::StreamName
          include Messages::Events

          extend Call
          prepend Configure

          category :account

          dependency :write, Messaging::Postgres::Write
          dependency :clock, Clock::UTC

          attr_accessor :previous_message

          virtual :configure
        end
      end

      module Configure
        def configure
          super
          Messaging::Postgres::Write.configure(self)
          Clock::UTC.configure(self)
        end
      end

      module Call
        def call(*arguments)
          instance = build(*arguments)
          instance.()
        end
      end
    end
  end
end
