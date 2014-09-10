class Wallet < ActiveRecord::Base
	belongs_to :user
	has_many :transactions
	has_many :keypairs
	belongs_to :curr_key, class_name: 'Keypair', foreign_key: 'keypair_ptr_id'

	# create initial keypair
	after_create :generate_keypair

	validates :label, presence: true
	validates :user_id, presence:

	# add new keypair (private key and public key) with
	# address and update the pointer to it. the pointer
	# always points to the newest (unused) keypair
	def generate_keypair
		key = Bitcoin::generate_key
		addr = Bitcoin::pubkey_to_address(key[1])
		svg = RQRCode::QRCode.new('bitcoin:' + addr, :size => 10, :level => 'h').to_svg

		keypair = Keypair.new(
			privkey: key[0],
			pubkey: key[1],
			address:  addr,
			addr_qrcode_svg: svg
		)

		self.keypairs.push(keypair)
		self.keypair_ptr_id = keypair.id
		save!
	end
	
end
