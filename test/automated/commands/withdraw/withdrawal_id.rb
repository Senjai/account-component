require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    context "Withdrawal ID" do
      account_id = Controls::Account.id
      amount = Controls::Money.example

      withdrawal_id = Controls::ID.example

      withdrawal = Commands::Withdraw.new account_id, amount
      withdrawal.withdrawal_id = withdrawal_id

      withdrawal.()

      write = withdrawal.write

      withdrawal = write.one_message do |written|
        written.instance_of?(Messages::Commands::Withdraw)
      end

      refute(withdrawal.nil?)

      test "Withdrawal ID is set" do
        assert(withdrawal.withdrawal_id == withdrawal_id)
      end
    end
  end
end
