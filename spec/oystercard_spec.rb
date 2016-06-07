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

# User Story 3
##############
# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

	it 'raises an error if the maximum balance is exceeded' do  
		maximum_balance = Oystercard::MAXIMUM_BALANCE
		subject.top_up(maximum_balance)   #set balance to be at maximum so when 1 is added, in test below, it exceeds maximum and will raise error
		expect{subject.top_up(1)}.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
	end
		
		# User Story 2
		##############
		# In order to keep using public transport
		# As a customer
		# I want to add money to my card

			describe '#top up' do  

				it {is_expected.to respond_to(:top_up).with(1).argument}

				it 'can increase the balance' do  
					expect {subject.top_up(1)}.to change{ subject.balance}.by(1)
				end

			end

			# User Story 4
			##############
			# In order to pay for my journey
			# As a customer
			# I need my fare deducted from my card

			describe '#deduct' do  

				it {is_expected.to respond_to(:deduct).with(1).argument}

				it 'can decrease the balance' do  
					subject.top_up(20)  # default balance = 0 so need to add an amount so the amount to be deducted can be tested
					expect {subject.deduct(3)}.to change{ subject.balance}.by(-3)
				end
			end

	# User Story 4
	##############
	# In order to get through the barriers.
	# As a customer
	# I need to touch in and out.

	it {is_expected.to respond_to(:touch_in)}

	it 'can touch in' do  
		subject.touch_in
		expect(subject).to be_in_journey
	end

	it {is_expected.to respond_to(:touch_out)}

	it 'can touch out' do
		subject.touch_in
		subject.touch_out
		expect(subject).not_to be_in_journey
	end

	it {is_expected.to respond_to(:in_journey?)}

	it 'is initially not in a journey' do  
		expect(subject.in_journey?).to eq false
	end
		
end