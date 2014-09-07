require_relative '../validators/bitcoin_address_validator'

# attribution: http://stackoverflow.com/questions/16865821/rails-4-validate-model-without-a-database
class Receiverqrcode
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :receiver_addr, :amount, :label, :message

    # validations

    # validate receiver address
    validates_with BitcoinAddressValidator

    validates :amount, :receiver_addr, presence: true

    def initialize(attributes = {})
        attributes.each do |name, value|
            send("#{name}=", value)
        end
    end

    def persisted?
        false
    end

    def to_svg
        # todo
        RQRCode::QRCode.new("", :size => 4, :level => 'h').to_svg
    end

    private
    def receiverqrcode_params
        receiverqrcode.require(:receiverqrcode).permit(:receiver_addr, :label, :amount, :message)
    end
end