require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do 

    it 'exists and has attributes' do 
        auction = Auction.new

        expect(auction).to be_a(Auction)
        expect(auction.items).to eq([])
    end

    it 'can add items to the auction' do 
        auction = Auction.new
        item1 = Item.new('Chalkware Piggy Bank')
        item2 = Item.new('Bamboo Picture Frame')

        auction.add_item(item1)
        auction.add_item(item2)

        expect(auction.items).to eq([item1, item2])
        expect(auction.item_names).to eq(['Chalkware Piggy Bank', 'Bamboo Picture Frame'])
    end
    
    it 'can find the unpopular items' do 
        item1 = Item.new('Chalkware Piggy Bank')
        item2 = Item.new('Bamboo Picture Frame')
        item3 = Item.new('Homemade Chocolate Chip Cookies')
        item4 = Item.new('2 Days Dogsitting')
        item5 = Item.new('Forever Stamps')

        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

        auction = Auction.new
        auction.add_item(item1)
        auction.add_item(item2)
        auction.add_item(item3)
        auction.add_item(item4)
        auction.add_item(item5)

        expect(item1.bids).to eq ({})

        item1.add_bid(attendee2, 20)
        item1.add_bid(attendee1, 22)
        item4.add_bid(attendee3, 50)

        expect(auction.unpopular_items).to eq([item2, item3, item5])
    end

    it 'can calculate the potential revenue' do
        item1 = Item.new('Chalkware Piggy Bank')
        item2 = Item.new('Bamboo Picture Frame')
        item3 = Item.new('Homemade Chocolate Chip Cookies')
        item4 = Item.new('2 Days Dogsitting')
        item5 = Item.new('Forever Stamps')

        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

        auction = Auction.new
        auction.add_item(item1)
        auction.add_item(item2)
        auction.add_item(item3)
        auction.add_item(item4)
        auction.add_item(item5)

        expect(item1.bids).to eq ({})

        item1.add_bid(attendee2, 20)
        item1.add_bid(attendee1, 22)
        item4.add_bid(attendee3, 50)
        item3.add_bid(attendee2, 15)
        
        expect(auction.potential_revenue).to eq(87)
    end

    it 'can return an array of bidders names' do 
        item1 = Item.new('Chalkware Piggy Bank')
        item2 = Item.new('Bamboo Picture Frame')
        item3 = Item.new('Homemade Chocolate Chip Cookies')
        item4 = Item.new('2 Days Dogsitting')
        item5 = Item.new('Forever Stamps')

        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

        auction = Auction.new

        auction.add_item(item1)
        auction.add_item(item2)
        auction.add_item(item3)
        auction.add_item(item4)
        auction.add_item(item5)

        item1.add_bid(attendee1, 22)
        item1.add_bid(attendee2, 20)
        item4.add_bid(attendee3, 50)
        item3.add_bid(attendee2, 15)

        expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end

    it 'can give bidder info' do 
        item1 = Item.new('Chalkware Piggy Bank')
        item2 = Item.new('Bamboo Picture Frame')
        item3 = Item.new('Homemade Chocolate Chip Cookies')
        item4 = Item.new('2 Days Dogsitting')
        item5 = Item.new('Forever Stamps')

        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

        auction = Auction.new

        auction.add_item(item1)
        auction.add_item(item2)
        auction.add_item(item3)
        auction.add_item(item4)
        auction.add_item(item5)

        item1.add_bid(attendee1, 22)
        item1.add_bid(attendee2, 20)
        item4.add_bid(attendee3, 50)
        item3.add_bid(attendee2, 15)

        expected = {
            attendee1 => {
                :budget => 50,
                :items => [item1]
            },
            attendee2 => {
                :budget => 75,
                :items => [item1, item3]
            },
            attendee3 => {
                :budget => 100,
                :items => [item4]
            }
        }

        expect(auction.bidder_info).to eq(expected)
    end
end