# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

def update_contract_cost(sharer)
  contracts = Contract.where(sharer_id: sharer.id)
  new_price = sharer.plan_cost/(contracts.length + 1)

  contracts.each do |c|
    c.price = new_price
    c.save
  end
end

for x in 1..500
    user = User.create! :email => "user#{x}@fakeemail.com", :password => 'topsecret', :password_confirmation => 'topsecret'
end

for x in 1..400
  r = rand(10)
  if r < 6
    Joiner.create(user_id: x, service: ["Netflix", "Disney+", "Hulu"].sample, status: "Pending")
    Joiner.create(user_id: x, service: ["Netflix", "Disney+", "Hulu"].sample, status: "Pending")
    joiner = Joiner.create(user_id: x, service: ["Netflix", "Disney+", "Hulu"].sample, status: "Pending")
    unless Sharer.first.nil?
      sharer = Sharer.where("size > ? AND user_id != ? AND service == ?", 0, joiner.user_id, joiner.service).order(:created_at).first
      unless sharer.nil?
        @contract = Contract.new(sharer_id: sharer.id, sharer_uid: sharer.user_id, joiner_uid: joiner.user_id, account_id: sharer.account_id, account_password: sharer.account_password, price: 0)
        if @contract.save
          joiner.status = "Complete"
          sharer.size = sharer.size - 1
          if sharer.size == 0
            sharer.status = "Complete"
          end
          joiner.save
          sharer.save
          update_contract_cost(sharer)
        end
      end
    end

  else
    n = [["Netflix",1,12.99],["Netflix",3,15.99],["Hulu",1,5.99],["Hulu",2,11.99],["Disney+",3,6.99]].sample
    Sharer.create(user_id: x, service: n[0], size: n[1], account_id:"helpme@me.com", account_password:"MOUSE", status: "Pending", plan_cost: n[2])
    ch = [["Netflix",1,12.99],["Netflix",3,15.99],["Hulu",1,5.99],["Hulu",2,11.99],["Disney+",3,6.99]].sample
    sharer = Sharer.create(user_id: x, service: ch[0], size: ch[1], account_id:"helpme@me.com", account_password:"MOUSE", status: "Pending", plan_cost: ch[2])
    unless Joiner.first.nil?
      joiners = Joiner.where("? != user_id AND ? == service AND status == ?", sharer.user_id, sharer.service, "Pending").order(:created_at).first(sharer.size)
        if joiners.length > 0
          sharer.size = sharer.size - joiners.length
          if sharer.size == 0
            sharer.status = "Complete"
          end
          sharer.save
          joiners.each do |j|
            #create the contracts
            @contract = Contract.new(sharer_id: sharer.id, sharer_uid: sharer.user_id, joiner_uid: j.user_id, account_id: sharer.account_id, account_password: sharer.account_password, price: 0)
            @contract.save
            j.status = "Complete"
            j.save
          end
          update_contract_cost(sharer)
        end
    end
  end
end

Contract.all.each do |c|
  (1..400).each do
      Message.create(content: "Hi, what's the new password?", contract_id: c.id, sender_email: "fake@email.com")
  end
end
