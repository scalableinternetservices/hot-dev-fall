class StaticPagesController < ApplicationController
  def about
  end

  def help
  end

  def home
      @user = User.find_by(params[:id])
      if @user.usertype == ""
          @need_further_setup = true
      end
  end

  def dataform
  end

end
