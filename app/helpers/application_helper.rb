module ApplicationHelper
	# create array of `[wallet label, recent wallet address]`
	def options_for_wallet_select
		out = []

		current_user.wallets.each do |w|
			out << [w.label, w.curr_key.address]
		end

		out
	end
end
