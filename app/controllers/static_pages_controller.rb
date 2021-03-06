class StaticPagesController < ApplicationController
  def about
  end

  def help
  end

  ContractSharedObject = Struct.new(:id, :service, :user_email, :user_id, :joiners_array, :price, :account_username)
  ContractJoinedObject = Struct.new(:id, :service, :owner_email, :account_username, :account_password, :price)
  ContractJoinerObject = Struct.new(:id, :user)
  def home
      if user_signed_in?
          sharer = Sharer.find_by(params[:id])
          joiner = Joiner.find_by(params[:id])
          @user = current_user

          if sharer.nil? && joiner.nil?
              @need_further_setup = true
          else
              @my_contracts_shared = []

              processed = Set.new

              Contract.where(sharer_uid: @user.id).find_each do |contract|
                if processed.include?(contract.sharer_id)
                  next
                end
                contractObject = ContractSharedObject.new

                shareRequest = Sharer.find(contract.sharer_id)

                contractObject.service = shareRequest.service
                contractObject.price = contract.price
                contractObject.joiners_array = []
                contractObject.account_username = contract.account_id
                contractObject.id = contract.id

                Contract.where(sharer_id: contract.sharer_id).find_each do |contract_joiner|
                  user = User.find(contract_joiner.joiner_uid)
                  joiner = ContractJoinerObject.new
                  joiner.id = contract_joiner.id
                  joiner.user = user
                  contractObject.joiners_array.push(joiner)
                end

                processed.add(contract.sharer_id)
                @my_contracts_shared.push(contractObject)
              end

              @my_contracts_joined = []
              Contract.where(joiner_uid: @user.id).find_each do |contract|
                contractObject = ContractJoinedObject.new

                contractObject.id = contract.id
                contractObject.account_username = contract.account_id
                contractObject.account_password = contract.account_password
                contractObject.price = contract.price

                shareRequest = Sharer.find(contract.sharer_id)

                contractObject.service = shareRequest.service

                creator = User.find(shareRequest.user_id)
                contractObject.owner_email = creator.email

                @my_contracts_joined.push(contractObject)
              end

              @my_share_requests = []
              Sharer.where(user_id: @user.id).where(status: "Pending").find_each do |share|
                @my_share_requests.push(share)
              end

              @my_join_requests = []
              Joiner.where(user_id: @user.id).where(status: "Pending").find_each do |join|
                @my_join_requests.push(join)
              end

              puts @user.id
              puts @my_contracts_shared
              puts @my_contracts_joined
              puts @my_share_requests
              puts @my_join_requests
          end
      else
      end

  end

  def dataform
  end

end
