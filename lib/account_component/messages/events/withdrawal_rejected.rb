module AccountComponent
  module Messages
    module Events
      class WithdrawalRejected
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        attribute :transaction_position, Integer
      end
    end
  end
end
