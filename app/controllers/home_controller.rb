class HomeController < ApplicationController
	def index
		# create new empty model for sidebar view
		@receiverqrcode = Receiverqrcode.new
	end
end
