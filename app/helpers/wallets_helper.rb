module WalletsHelper
	def wallet_export_path wallet
		wallet.id.to_s + "/export"
	end
end
