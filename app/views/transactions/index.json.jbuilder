json.array!(@transactions) do |transaction|
    json.extract! transaction, :id, :receiver_addr, :amount, :fee
    json.url transaction_url(transaction, format: :json)
end
