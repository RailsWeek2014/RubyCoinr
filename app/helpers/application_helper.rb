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
	
end
