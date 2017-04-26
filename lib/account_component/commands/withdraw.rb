module AccountComponent
  module Commands
    class Withdraw
      include Command

      configure :withdraw

      dependency :identifier, Identifier::UUID::Random

      def withdrawal_id
        @withdrawal_id ||= identifier.get
      end
      attr_writer :withdrawal_id

      attr_accessor :reply_stream_name

      initializer :account_id, :amount

      def configure
        Identifier::UUID::Random.configure(self)
      end

      def self.build(account_id, amount, withdrawal_id: nil, reply_stream_name: nil, previous_message: nil)
        instance = new account_id, amount

        instance.withdrawal_id = withdrawal_id unless withdrawal_id.nil?
        instance.reply_stream_name = reply_stream_name unless reply_stream_name.nil?
        instance.previous_message = previous_message unless previous_message.nil?

        instance.configure
        instance
      end

      def call
        stream_name = command_stream_name(account_id)

        withdraw = Messages::Commands::Withdraw.build

        unless previous_message.nil?
          withdraw.metadata.follow(previous_message.metadata)
        end

        withdraw.withdrawal_id = withdrawal_id
        withdraw.account_id = account_id
        withdraw.amount = amount
        withdraw.time = clock.iso8601

        write.(withdraw, stream_name, reply_stream_name: reply_stream_name)

        withdraw
      end
    end
  end
end
