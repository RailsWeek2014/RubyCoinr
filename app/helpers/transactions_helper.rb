module TransactionsHelper
	def wallet_label_for_id id
		Wallet.find(id).label
	end

	def wallet_addr_for_id id
		Wallet.find(id).curr_key.address
	end

end
