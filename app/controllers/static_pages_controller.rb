class StaticPagesController < ApplicationController
  def about
  end

  def help
  end

  ContractSharedObject = Struct.new(:service, :user_email, :user_id, :joiners_array)
  ContractJoinedObject = Struct.new(:service, :owner_email, :account_username, :account_password)
  def home
      if user_signed_in?
          sharer = Sharer.find_by(params[:id])
          joiner = Joiner.find_by(params[:id])
          @user = current_user

          if sharer.nil? && joiner.nil?
              @need_further_setup = true
          else
              @my_contracts_shared = []
              Contract.where(sharer_uid: @user.id).find_each do |contract|
                contractObject = ContractSharedObject.new
                contractObject.service = "Netflix"
                contractObject.joiners_array = []
                Joiner.where(user_id:contract.joiner_uid).find_each do |contract_joiner|
                    user = User.find(contract_joiner.user_id)
                    contractObject.joiners_array.push(user)
                end
                @my_contracts_shared.push(contractObject)
              end

              @my_contracts_joined = []
              Contract.where(joiner_uid: @user.id).find_each do |contract|
                contractObject = ContractJoinedObject.new
                contractObject.service = "Netflix"
                Sharer.where(user_id:contract.sharer_uid).find_each do |contract_creator|
                    user = User.find(contract_creator.user_id)
                    contractObject.owner_email = user.email
                    contractObject.account_username = contract.account_id
                    contractObject.account_password = contract.account_password
                end
                @my_contracts_joined.push(contractObject)
              end

              @my_share_requests = []
              Sharer.where(user_id: @user.id).find_each do |share|
                @my_share_requests.push(share)
              end

              @my_join_requests = []
              Joiner.where(user_id: @user.id).find_each do |join|
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
