class Item

attr_reader :name, :bids
    def initialize(name)
        @name = name
        @bids = {}
        @bidding = true
    end

    def add_bid(attendee, amount)
        @bids[attendee] = amount if @bidding == true
    end

    def current_high_bid
        @bids.values.max #doesn't take empty bids into account - can fix with pre: if @bids.empty? return 0 else return bids.values.max
    end

    def close_bidding
        @bidding = false
    end
end