require 'oystercard'

describe Oystercard do 

# User Story 1
##############
# In order to use public transport
# As a customer
# I want money on my card

	it 'has initial balance' do 
		expect(subject.balance).to eq(0)
	end

# User Story 2
##############
# In order to keep using public transport
# As a customer
# I want to add money to my card

	describe '#top up' do  

		it 'responds to #top up' do
		# it {is_expected.to respond_to(:top_up).with(1).argument}
		 	expect {subject.to respond_to(:top_up).with(1).argument}
		end

		it 'can increase the balance' do  
			expect { subject.top_up(1)}.to change{ subject.balance }.by(1)
		end

	end

end