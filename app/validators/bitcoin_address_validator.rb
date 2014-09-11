class BitcoinAddressValidator < ActiveModel::Validator

    # validates bitcoin address
    def validate(record)
        # receiver address
        record.errors.add(:receiver_addr, "invalid") unless Bitcoin::valid_address?(record.receiver_addr)

        # sender address
        begin
            if record.sender_addr
                record.errors.add(:sender_addr, "invalid") unless Bitcoin::valid_address?(record.sender_addr)
            end
        rescue
        end
    end

end