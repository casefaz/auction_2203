require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Item do 

    it 'exists and has attributes' do 
        item1 = Item.new('Chalkware Piggy Bank')
        item2 = Item.new('Bamboo Picture Frame')

        expect(item1).to be_a(Item)
        expect(item1.name).to eq('Chalkware Piggy Bank')
        expect(item1.bids).to eq({})
    end

    it 'can add bids to items' do 
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
        
        expected = {
            attendee2 => 20,
            attendee1 => 22
        }
        expect(item1.bids).to eq(expected)
    end

    it 'can find the highest bid' do 
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
        
        expected = {
            attendee2 => 20,
            attendee1 => 22
        }
        expect(item1.bids).to eq(expected)
        expect(item1.current_high_bid).to eq(22)
    end

    it 'can prevent further bids from being placed on an item' do 
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
            attendee1 => 22,
            attendee2 => 20
        }

        expect(item1.bids).to eq(expected)

        item1.close_bidding

        item1.add_bid(attendee3, 70)

        expect(item1.bids).to eq(expected)
    end
end