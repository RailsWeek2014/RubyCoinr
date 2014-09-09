class BitcoinAddressValidator < ActiveModel::Validator

	# validates bitcoin address
	def validate(record)
		# receiver address
		record.errors.add(:receiver_addr, "invalid") unless Bitcoin::valid_address?(record.receiver_addr)

		# sender address
		if record.sender_addr
			record.errors.add(:receiver_addr, "invalid") unless Bitcoin::valid_address?(record.sender_addr)
		end
	end

end