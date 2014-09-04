class Wallet < ActiveRecord::Base
	belongs_to :user
	has_many :transactions

	after_create :generate_keypair

	def generate_keypair
		self.privkey, self.pubkey = Bitcoin::generate_key
		self.address = Bitcoin::pubkey_to_address(self.pubkey)
		save!
	end
	
end
