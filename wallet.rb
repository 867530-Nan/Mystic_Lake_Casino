class Wallet
    attr_accessor :amount

    def initialize(amount)
        @amount = amount.to_f
    end

    def in_debt?
      @amount > 0
    end
end
