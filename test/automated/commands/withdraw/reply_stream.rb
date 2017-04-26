require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    context "Reply Stream" do
      account_id = Controls::Account.id
      amount = Controls::Money.example

      reply_stream = 'someReplyStream'

      withdrawal = Commands::Withdraw.new account_id, amount
      withdrawal.reply_stream_name = reply_stream

      withdrawal.()

      write = withdrawal.write

      withdrawal = write.one_message do |written|
        written.instance_of?(Messages::Commands::Withdraw)
      end

      refute(withdrawal.nil?)

      test "Reply stream is set" do
        assert(withdrawal.metadata.reply_stream_name == reply_stream)
      end
    end
  end
end
