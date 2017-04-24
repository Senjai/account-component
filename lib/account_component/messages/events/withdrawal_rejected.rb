module AccountComponent
  module Messages
    module Events
      class WithdrawalRejected
        include Messaging::Message

        # TODO Add withdrawal ID attribute
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        attribute :transaction_position, Integer
      end
    end
  end
end
