
# create new qr codes for easier receivement bitcoins
# see: http://stackoverflow.com/questions/16865821/rails-4-validate-model-without-a-database
class ReceiverqrcodeController < ApplicationController
	include ReceiverqrcodeHelper
	
	# create new empty Receiverqrcode
	def new
		@receiverqrcode = Receiverqrcode.new
	end

	# POST request received; populate with given data
	# get’s validated in `models/receiverqrcode`
	def create
		receiverqrcode_pars = params[:receiverqrcode]

		if receiverqrcode_pars
			# build attributes and create new receiverqrcode
			@receiverqrcode = Receiverqrcode.new(
				receiver_addr: receiverqrcode_pars[:receiver_addr],
				amount: receiverqrcode_pars[:amount],
				label: receiverqrcode_pars[:label],
				message: receiverqrcode_pars[:message]
				)

			if @receiverqrcode.valid?
				@btc_url = get_payment_url_from_params(receiverqrcode_pars)

				# a qr code of the size 14 can hold exactly 1576 bits
				# 28 bits are reserved for the amount
				begin
					@receiverqrcode_svg = RQRCode::QRCode.new(@btc_url, :size => 14, :level => 'h').to_svg
				rescue Exception
					@receiverqrcode.errors.add(:base, 'Label and/or message too long. Please review your payment information.')
				end
			end
		end

		render action: 'new'
	end

	private
	def receiverqrcode_params
		params.require(:receiverqrcode).permit(:receiver_addr, :label, :amount, :message)
	end
end