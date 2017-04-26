require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    account_id = Controls::Account.id
    deposit_id = Controls::ID.example
    amount = Controls::Money.example
    effective_time = Controls::Time::Effective::Raw.example

    deposit = Commands::Deposit.new(account_id, amount)

    deposit.identifier.set(deposit_id)

    deposit.clock.now = effective_time

    deposit.()

    write = deposit.write

    deposit = write.one_message do |written|
      written.instance_of?(Messages::Commands::Deposit)
    end

    test "Deposit command is written" do
      refute(deposit.nil?)
    end

    test "Written to the account command stream" do
      written_to_stream = write.written?(deposit) do |stream_name|
        stream_name == "account:command-#{account_id}"
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "deposit_id is assigned" do
        assert(deposit.deposit_id == deposit_id)
      end

      test "account_id" do
        assert(deposit.account_id == account_id)
      end

      test "amount" do
        assert(deposit.amount == amount)
      end

      test "time" do
        effective_time_iso8601 = Clock.iso8601(effective_time)

        assert(deposit.time == effective_time_iso8601)
      end
    end
  end
end
