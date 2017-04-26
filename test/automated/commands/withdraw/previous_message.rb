require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    context "Previous Message" do
      previous_message = Controls::Message.example

      account_id = Controls::Account.id
      amount = Controls::Money.example

      withdrawal = Commands::Withdraw.new account_id, amount
      withdrawal.previous_message = previous_message
      withdrawal.clock.now = Controls::Time::Raw.example

      withdrawal.()

      write = withdrawal.write

      withdrawal = write.one_message do |written|
        written.instance_of?(Messages::Commands::Withdraw)
      end

      refute(withdrawal.nil?)

      test "Withdraw command follows previous message" do
        assert(withdrawal.follows?(previous_message))
      end
    end
  end
end
