require_relative '../automated_init'

context "Projection" do
  context "Deposited" do
    deposited = Controls::Events::Deposited.example

    context do
      account = Controls::Account::Balance.example
      prior_balance = account.balance

      position = deposited.transaction_position or fail

      Projection.(account, deposited)

      test "Account balance is increased" do
        assert(account.balance == prior_balance + deposited.amount)
      end

      test "Transaction position is set" do
        assert(account.transaction_position == position)
      end
    end

    context "ID Is Set" do
      account = Controls::Account::New.example

      assert(account.id.nil?)
      account_id = deposited.account_id or fail

      Projection.(account, deposited)

      test do
        assert(account.id == account_id)
      end
    end
  end
end
