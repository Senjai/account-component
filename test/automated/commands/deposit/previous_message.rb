require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    context "Previous Message" do
      previous_message = Controls::Message.example

      account_id = Controls::Account.id
      amount = Controls::Money.example

      deposit = Commands::Deposit.new account_id, amount
      deposit.previous_message = previous_message
      deposit.clock.now = Controls::Time::Raw.example

      deposit.()

      write = deposit.write

      deposit = write.one_message do |written|
        written.instance_of?(Messages::Commands::Deposit)
      end

      refute(deposit.nil?)

      test "Deposit command follows previous message" do
        assert(deposit.follows?(previous_message))
      end
    end
  end
end
