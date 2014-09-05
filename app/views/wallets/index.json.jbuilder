json.array!(@wallets) do |wallet|
  json.extract! wallet, :id, :label
  json.url wallet_url(wallet, format: :json)
end
