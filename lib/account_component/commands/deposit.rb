module AccountComponent
  module Commands
    class Deposit
      include Command

      configure :deposit

      dependency :identifier, Identifier::UUID::Random

      def deposit_id
        @deposit_id ||= identifier.get
      end
      attr_accessor :deposit_id

      attr_accessor :reply_stream_name

      initializer :account_id, :amount

      def configure
        Identifier::UUID::Random.configure(self)
      end

      def self.build(account_id, amount, deposit_id: nil, reply_stream_name: nil, previous_message: nil)
        instance = new account_id, amount

        instance.deposit_id = deposit_id unless deposit_id.nil?
        instance.reply_stream_name = reply_stream_name unless reply_stream_name.nil?
        instance.previous_message = previous_message unless previous_message.nil?

        instance.configure
        instance
      end

      def call
        deposit = Messages::Commands::Deposit.build

        unless previous_message.nil?
          deposit.metadata.follow(previous_message.metadata)
        end

        deposit.deposit_id = deposit_id
        deposit.account_id = account_id
        deposit.amount = amount
        deposit.time = clock.iso8601

        stream_name = command_stream_name(account_id)

        write.(deposit, stream_name, reply_stream_name: reply_stream_name)

        deposit
      end
    end
  end
end
