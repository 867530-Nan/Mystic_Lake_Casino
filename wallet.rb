class Wallet
    attr_accessor :amount

    def initialize(amount = nil, max = 100)
        @amount = ( amount || rand(1..max))
    end

    def in_debt?
      @amount < 0
    end

    def print_current_balance
        puts 
        print "You have exactly "
        print @amount
        print " have left in your wallet."
    end    
end