require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    context "Reply Stream" do
      account_id = Controls::Account.id
      amount = Controls::Money.example

      reply_stream = 'someReplyStream'

      deposit = Commands::Deposit.new account_id, amount
      deposit.reply_stream_name = reply_stream

      deposit.()

      write = deposit.write

      deposit = write.one_message do |written|
        written.instance_of?(Messages::Commands::Deposit)
      end

      refute(deposit.nil?)

      test "Reply stream is set" do
        assert(deposit.metadata.reply_stream_name == reply_stream)
      end
    end
  end
end
