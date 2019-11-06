json.extract! contract, :id, :sharer, :joiners, :username, :password, :created_at, :updated_at
json.url contract_url(contract, format: :json)
