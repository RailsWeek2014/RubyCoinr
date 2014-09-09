module ApplicationHelper

	# create array of `[wallet label, wallet id]`
	def options_for_wallet_select
		out = []

		current_user.wallets.each do |w|
			out << [w.label, w.id]
		end

		out
	end

	# create array of `[ wallet label, recent wallet id]`
	def options_for_wallet_addr_select
		out = []

		current_user.wallets.each do |w|
			out << [w.label, w.curr_key.address]
		end

		out
	end

	# TODO
	def confirmed_incoming_txs_count
		0
	end

	# TODO
	def unconfirmed_incoming_txs_count
		0
	end

	def confirmed_outgoing_txs_count
		count = 0

		if current_user.wallets.any?
			current_user.wallets.each do |w|
				if w.transactions.any?
					w.transactions.each do |tx|
						if tx.confirmed
							count += 1
						end
					end
				end
			end
		end

		count

	end

	def unconfirmed_outgoing_txs_count
		count = 0

		if current_user.wallets.any?
			current_user.wallets.each do |w|
				if w.transactions.any?
					w.transactions.each do |tx|
						count += 1 unless tx.confirmed
					end
				end
			end
		end

		count
	end

	
end
