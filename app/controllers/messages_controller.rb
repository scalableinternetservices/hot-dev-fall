class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :get_messages_for_contract, only: [:show]
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
      @message = Message.new
      @contract_id = params[:id]

      print @contract_id

      @messages.each do | message |
          print message.content
      end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    # PROBLEM: you can see other people's messages. Need to authenticate somehow.
    new_route = "/messages/" + message_params["contract_id"].to_s

    respond_to do |format|
      if @message.save
        format.html { redirect_to new_route }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def get_messages_for_contract
        @messages = []
        Message.where(contract_id:params[:id]).find_each do |message|
            @messages.push(message)
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.fetch(:message, {})
       params.require(:message).permit(:content, :contract_id, :sender_email)
    end
end
