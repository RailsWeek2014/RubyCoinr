class BitcoinAddressValidator < ActiveModel::Validator

	# validates bitcoin address
	def validate(record)
		record.errors.add(:receiver_addr, "invalid") unless Bitcoin::valid_address?(record.receiver_addr)
	end

end