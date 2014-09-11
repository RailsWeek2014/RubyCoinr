require 'erb'

module ReceiverqrcodeHelper
    include ERB::Util # for url encoding

    def get_payment_url address, amount, label, message
        # address and amount are required
        out = "bitcoin:#{ address }?amount=#{ amount }"

        if label != ""
            out += "&label=#{ u(label) }"
        end

        if message != ""
            out += "&message=#{ u(message) }"
        end

        out
    end

    def get_payment_url_from_params params
        receiver_addr = params[:receiver_addr]
        amount = params[:amount]
        label = params[:label]
        message = params[:message]

        get_payment_url(receiver_addr, amount, label, message)
    end

    # paths
    def new_receiverqrcode_path
        "receiverqrcode/new"
    end

    def receiverqrcodes_path
        "receiverqrcode"
    end
end