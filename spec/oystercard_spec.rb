require 'oystercard'

describe Oystercard do 

	it 'has initial balance' do 
		expect(subject.balance).to eq(0) #starting balance of 0
	end

	it 'cannot touch in if card is below the minimum balance' do  
		expect{subject.touch_in}.to raise_error 'Insufficient balance to touch in'
	end

	it 'raises an error if the maximum balance is exceeded' do  
		maximum_balance = Oystercard::MAXIMUM_BALANCE
		subject.top_up(maximum_balance)   #set balance to be at maximum so when 1 is added, in test below, it exceeds maximum and will raise error
		expect{subject.top_up(1)}.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
	end

	it 'can charge card with amount for journey' do  
		subject.top_up(20) # to counter the min balance of less than 1 default value
		subject.touch_in
		expect{subject.touch_out}.to change {subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
	end

		context '#top up' do  

			it {is_expected.to respond_to(:top_up).with(1).argument}

			it 'can increase the balance' do  
				expect {subject.top_up(1)}.to change{ subject.balance}.by(1)
			end

		end

		context '#touch in, #touch out, #in journey' do  

			before :each do
				subject.top_up(10)
			end

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
end