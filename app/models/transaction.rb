require_relative '../validators/bitcoin_address_validator'

class Transaction < ActiveRecord::Base
	# include Bitcoin::Builder
	
	belongs_to :wallet

	validates :receiver_addr, presence: true
	validates :amount, presence: true, numericality: true
	validates :fee, presence: true, numericality: true
	validate :fee_should_be_less_than_amount, if: 'fee && amount'
	validate :wallet_id, presence: true

	# validates receiver_addr
	validates_with BitcoinAddressValidator

	# validate fee
	def fee_should_be_less_than_amount
		if fee >= amount
			errors.add(:fee, "has to be less than amount")
		end
	end
end
