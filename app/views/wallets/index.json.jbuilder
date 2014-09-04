json.array!(@wallets) do |wallet|
  json.extract! wallet, :id, :label, :password
  json.url wallet_url(wallet, format: :json)
end
