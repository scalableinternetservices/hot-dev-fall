json.extract! contract, :id, :sharer_id, :joiners_id, :username, :password, :created_at, :updated_at
json.url contract_url(contract, format: :json)
