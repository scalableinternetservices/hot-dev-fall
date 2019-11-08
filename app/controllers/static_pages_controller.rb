class StaticPagesController < ApplicationController
  def about
  end

  def help
  end

  def home
      @user = User.find_by(params[:id])
      if @user.nil? || @user.usertype == ""
          @need_further_setup = true
      end
      
      @my_contracts_shared = []
      Contract.where(sharer_uid: @user.id).find_each do |contract|
        @my_contracts_shared.push(contract)
      end

      @my_contracts_joined = []
      Contract.where(joiner_uid: @user.id).find_each do |contract|
        @my_contracts_joined.push(contract)
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

  def dataform
  end

end
