require 'oystercard'

describe Oystercard do 

# User Story 1
##############
# I want money on my card

	it 'has initial balance' do 
		expect(subject.balance).to eq(0) #starting balance of 0
	end

# User Story 6
##############
# I need to have the minimum amount (£1) for a single journey.

	it 'cannot touch in if card is below the minimum balance' do  
		expect{subject.touch_in}.to raise_error 'Insufficient balance to touch in'
	end

# User Story 3
##############
# I want a maximum limit (of £90) on my card

	it 'raises an error if the maximum balance is exceeded' do  
		maximum_balance = Oystercard::MAXIMUM_BALANCE
		subject.top_up(maximum_balance)   #set balance to be at maximum so when 1 is added, in test below, it exceeds maximum and will raise error
		expect{subject.top_up(1)}.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
	end
		
		# User Story 2
		##############
		# I want to add money to my card

			describe '#top up' do  

				it {is_expected.to respond_to(:top_up).with(1).argument}

				it 'can increase the balance' do  
					expect {subject.top_up(1)}.to change{ subject.balance}.by(1)
				end

			end

			# User Story 4
			##############
			# I need my fare deducted from my card

			describe '#deduct' do  

				it {is_expected.to respond_to(:deduct).with(1).argument}

				it 'can decrease the balance' do  
					subject.top_up(20)  # default balance = 0 so need to add an amount so the amount to be deducted can be tested
					expect{subject.deduct(3)}.to change{ subject.balance}.by(-3)
				end
			end

	# User Story 5
	##############
	# I need to touch in and out.

	it {is_expected.to respond_to(:touch_in)}

	it 'can touch in' do 
		subject.top_up(10) # new test (user story 6) defaults balance to < 1 so cannot touch in, so need to top up card to run this test
		subject.touch_in
		expect(subject).to be_in_journey
	end

	it {is_expected.to respond_to(:touch_out)}

	it 'can touch out' do
		subject.top_up(10) # new test (user story 6) defaults balance to < 1 so cannot touch in, so need to top up card to run this test
		subject.touch_in
		subject.touch_out
		expect(subject).not_to be_in_journey
	end

	it {is_expected.to respond_to(:in_journey?)}

	it 'is initially not in a journey' do  
		expect(subject.in_journey?).to eq false
	end

end