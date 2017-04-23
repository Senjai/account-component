require_relative '../automated_init'

context "Account" do
  context "Current" do
    position = Controls::Position.example

    context "Not current" do
      context "Account's position is lower than transaction's position" do
        account = Controls::Account.example(transaction_position: position - 1)

        current = account.current?(position)

        test do
          refute(current)
        end
      end

      context "Account's position is nil" do
        account = Controls::Account.example(transaction_position: nil)

        current = account.current?(position)

        test do
          refute(current)
        end
      end
    end

    context "Is current" do
      context "Account's position is greater than transaction's position" do
        account = Controls::Account.example(transaction_position: position + 1)

        current = account.current?(position)

        test do
          assert(current)
        end
      end

      context "Account's position is equal to than transaction's position" do
        account = Controls::Account.example(transaction_position: position)

        current = account.current?(position)

        test do
          assert(current)
        end
      end
    end
  end
end
