class Oystercard

	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1

	attr_reader :balance, :touch

	def initialize
		@balance = 0
		@touch = false
	end

	def top_up(amount)
		fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
		@balance += amount
	end

	def touch_in
		fail 'Insufficient balance to touch in' if balance < MINIMUM_BALANCE
		@touch = true
	end

	def touch_out
		deduct(MINIMUM_BALANCE)
		@touch = false
	end

	def in_journey?
		@touch
	end

	private

	def deduct(amount)
		@balance -= amount
	end

end