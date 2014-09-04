class Wallet < ActiveRecord::Base
	belongs_to :user
	has_many :transactions
	has_many :addresses

	after_create :generate_keypair

	def generate_keypair
		self.privkey, self.pubkey = Bitcoin::generate_key
		save!
	end

	def generate_address
		addresses.push(
			Address.new(
				addr:
					Bitcoin::pubkey_to_address(pubkey)
			)
		)
	end
	
end
