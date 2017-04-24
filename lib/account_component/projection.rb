module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Opened do |opened|
      account.id = opened.account_id
      account.customer_id = opened.customer_id

      opened_time = Time.parse(opened.time)

      account.opened_time = opened_time
    end

    apply Deposited do |deposited|
      account.id = deposited.account_id

      amount = deposited.amount

      account.deposit(amount)

      account.transaction_position = deposited.transaction_position
    end

    apply Withdrawn do |withdrawn|
      account.id = withdrawn.account_id

      amount = withdrawn.amount

      account.withdraw(amount)

      account.transaction_position = withdrawn.transaction_position
    end

    apply WithdrawalRejected do |withdrawal_rejected|
      account.transaction_position = withdrawal_rejected.transaction_position
    end

    apply Closed do |closed|
      closed_time = Time.parse(closed.time)

      account.closed_time = closed_time
    end
  end
end
