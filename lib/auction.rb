class Auction

attr_reader :items
    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        items.map! { |item| item.name }
    end

    def unpopular_items
        items.find_all { |item| item.bids == {} }
    end

    def potential_revenue
        #the total of all the items highests bids - take into account current_high_bid
        items.map { |item| item.current_high_bid }.compact!.sum
    end
    
    def bidders
        # items.flat_map { |item| item.bids.keys.map { |attributes| attributes.name }}.uniq #doesn't work if you have more than one person with the same name, can solve by iterating over objects, rather than names - call uniq on item.bids.keys instead of name
        attendees = @items.flat_map { |item| item.bids.keys }.uniq
        attendees.map { |attendee| attendee.name }
    end

    def bidder_info
        bidders_stats = {}
        # attendees = items.find_all { |item| item.bids != {} } 
        # attendees.each do |attendee|
        #     bidders_info[attendee.bids] = {budget:0, items: []}
        # end
        items.each do |item|
            item.bids.keys.each do |attendee|
                if !bidders_stats.include?(attendee)
                    bidders_stats[attendee] = {
                        :budget => attendee.budget,
                        :items => [item]
                    }
                else
                    bidders_stats[attendee][:items] << item
                end
            end
        end
        bidders_stats
    end
end