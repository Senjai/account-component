module AccountComponent
  module Controls
    module Account
      def self.example(balance: nil, transaction_position: nil)
        balance ||= self.balance

        account = AccountComponent::Account.build

        account.id = id
        account.balance = balance
        account.opened_time = Time::Effective::Raw.example

        account.transaction_position = transaction_position unless transaction_position.nil?

        account
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        11
      end

      def self.balance
        Money.example
      end

      module New
        def self.example
          AccountComponent::Account.build
        end
      end

      module Open
        def self.example
          Account.example
        end
      end

      module Balance
        def self.example
          Account.example(balance: self.amount)
        end

        def self.amount
          11.1
        end
      end

      module Position
        def self.example
          position = Controls::Position.example

          Account.example(transaction_position: position)
        end
      end

      module Closed
        def self.example
          account = Account.example
          account.closed_time = Time::Effective::Raw.example
          account
        end
      end
    end
  end
end
