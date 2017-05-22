class Wallet
    attr_accessor :amount

    def initialize(amount = nil, max = 100)
        @amount = ( amount || rand(1..max))
    end

    def in_debt?
      @amount > 0
    end
end
