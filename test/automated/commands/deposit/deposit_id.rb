require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    context "Deposit ID" do
      account_id = Controls::Account.id
      amount = Controls::Money.example

      deposit_id = Controls::ID.example

      deposit = Commands::Deposit.new account_id, amount
      deposit.deposit_id = deposit_id

      deposit.()

      write = deposit.write

      deposit = write.one_message do |written|
        written.instance_of?(Messages::Commands::Deposit)
      end

      refute(deposit.nil?)

      test "Deposit ID is set" do
        assert(deposit.deposit_id == deposit_id)
      end
    end
  end
end
