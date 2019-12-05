# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

n_users = 150

def update_contract_cost(sharer)
    contracts = Contract.where(sharer_id: sharer.id)
    new_price = sharer.plan_cost/(contracts.length + 1)

    contracts.each do |c|
      c.price = new_price
      c.save
    end
end

for user_id in 1..n_users
    user = User.create! :email => "user#{user_id}@fakeemail.com", :password => 'topsecret', :password_confirmation => 'topsecret'
end

puts "CREATED: #{User.count} Users"

for user_id in 1..n_users
    for i in 1...rand(0...50)
        r = rand(10)
        if r <= 6
            #   Joiner.create(user_id: user_id, service: ["Netflix", "Disney+", "Hulu"].sample, status: "Pending")
            #   Joiner.create(user_id: user_id, service: ["Netflix", "Disney+", "Hulu"].sample, status: "Pending")
            joiner = Joiner.create(user_id: user_id, service: ["Netflix", "Disney+", "Hulu"].sample, status: "Pending")
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
            #   Sharer.create(user_id: user_id, service: n[0], size: n[1], account_id:"helpme@me.com", account_password:"MOUSE", status: "Pending", plan_cost: n[2])
            ch = [["Netflix",1,12.99],["Netflix",3,15.99],["Hulu",1,5.99],["Hulu",2,11.99],["Disney+",3,6.99]].sample

            account_id = (0..8).map{('a'..'z').to_a[rand(26)]}.join
            account_password = (0..8).map{('a'..'z').to_a[rand(26)]}.join

            sharer = Sharer.create(user_id: user_id, service: ch[0], size: ch[1], account_id:account_id, account_password:account_password, status: "Pending", plan_cost: ch[2])
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
end

puts "CREATED:"
puts "COUNT: #{Contract.count} Contracts"
puts "COUNT: #{Sharer.count} Share Reqs"
puts "COUNT: #{Joiner.count} Join Reqs"

puts "COUNT: #{Joiner.where("status == ?", "Pending").count} PENDING JOIN REQS"
puts "COUNT: #{Sharer.where("status == ?", "Pending").count} PENDING SHARE REQS"

puts "COUNT: #{Joiner.where("status == ?", "Complete").count} COMPLETE JOIN REQS"
puts "COUNT: #{Sharer.where("status == ?", "Complete").count} COMPLETE SHARE REQS"

puts "FINISHED HOME PAGE SEEDING STUFF"

Contract.all.each do |c|
    for i in 1...rand(0...25)
        Message.create(content: (0..8).map{('a'..'z').to_a[rand(26)]}.join, contract_id: c.id, sender_email: "fake@email.com")
    end
end

puts "COUNT: #{Message.count} Messages"
puts "FINISHED MESSAGE SEEDING STUFF"
