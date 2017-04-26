require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    account_id = Controls::Account.id
    withdrawal_id = Controls::ID.example
    amount = Controls::Money.example
    effective_time = Controls::Time::Effective::Raw.example

    withdrawal = Commands::Withdraw.new(account_id, amount)

    withdrawal.identifier.set(withdrawal_id)

    withdrawal.clock.now = effective_time

    withdrawal.()

    write = withdrawal.write

    withdrawal = write.one_message do |written|
      written.instance_of?(Messages::Commands::Withdraw)
    end

    test "Withdraw command is written" do
      refute(withdrawal.nil?)
    end

    test "Written to the account command stream" do
      written_to_stream = write.written?(withdrawal) do |stream_name|
        stream_name == "account:command-#{account_id}"
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "withdrawal_id is assigned" do
        assert(withdrawal.withdrawal_id == withdrawal_id)
      end

      test "account_id" do
        assert(withdrawal.account_id == account_id)
      end

      test "amount" do
        assert(withdrawal.amount == amount)
      end

      test "time" do
        effective_time_iso8601 = Clock.iso8601(effective_time)

        assert(withdrawal.time == effective_time_iso8601)
      end
    end
  end
end
