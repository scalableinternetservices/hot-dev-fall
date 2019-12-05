class SharersController < ApplicationController
  before_action :set_sharer, only: [:show, :edit, :update, :destroy]

  # GET /sharers
  # GET /sharers.json
  def index
    http_cache_forever(public: true) {}
  end

  # GET /sharers/1
  # GET /sharers/1.json
  def show
  end

  # GET /sharers/new
  def new
    @sharer = Sharer.new
  end

  # GET /sharers/1/edit
  def edit
  end

  # POST /sharers
  # POST /sharers.json
  def create

    @sharer = Sharer.new(sharer_params)
    
    if !current_user.nil?
      @sharer.user_id = current_user.id
    end

    service = sharer_params["service"]
    plan = sharer_params["size"]

    computed_size = 1
    computed_cost = 0.0

    if service == "Netflix" && plan == "Standard"
      computed_size = 1
      computed_cost = 12.99
    end

    if service == "Netflix" && plan == "Premium"
      computed_size = 3
      computed_cost = 15.99
    end

    if service == "Hulu" && plan == "Standard"
      computed_size = 1
      computed_cost = 5.99
    end

    if service == "Hulu" && plan == "Premium"
      computed_size = 2
      computed_cost = 11.99
    end

    if service == "Disney+"
      computed_size = 3
      computed_cost = 6.99
    end

    @sharer.size = computed_size
    @sharer.plan_cost = computed_cost

    #sharer should have a pending status
    respond_to do |format|
      if @sharer.save
        unless Joiner.first.nil?
          joiners = Joiner.where("? != user_id AND ? == service AND status == ?", @sharer.user_id, @sharer.service, "Pending").order(:created_at).first(@sharer.size)
          if joiners.length > 0
            @sharer.size = @sharer.size - joiners.length
            if @sharer.size == 0
              @sharer.status = "Complete"
            end
            @sharer.save
            joiners.each do |j|
              #create the contracts
              @contract = Contract.new(sharer_id:@sharer.id, sharer_uid: @sharer.user_id, joiner_uid: j.user_id, account_id: @sharer.account_id, account_password: @sharer.account_password, price: 0)
              @contract.save
              puts "MATCHED SHARER #{@sharer.user_id} TO #{j.user_id}"
              j.status = "Complete"
              j.save
            end
            update_contract_cost(@sharer)
          end
        end
          format.html { redirect_to "/" }
          format.json { render :show, status: :ok, location: @sharer }
      else
          format.html { render :new }
          format.json { }
      end
    end
  end

  # Note the race condition
  def update_contract_cost(sharer)
    # find contracts with sharer_id
    # use new size to update costs

    contracts = Contract.where(sharer_id: sharer.id)
    new_price = sharer.plan_cost/(contracts.length + 1)

    puts "Updating cost of #{contracts.length} contracts to new cost of #{new_price} for sharer #{sharer.id}"
    contracts.each do |c|
      c.price = new_price
      c.save
    end
  end

  # PATCH/PUT /sharers/1
  # PATCH/PUT /sharers/1.json
  def update
    # respond_to do |format|
    #   if @sharer.update(sharer_params)
    #     format.html { redirect_to @sharer, notice: 'Sharer was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @sharer }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @sharer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /sharers/1
  # DELETE /sharers/1.json
  def destroy
    # @sharer.destroy
    # respond_to do |format|
    #   format.html { redirect_to sharers_url, notice: 'Sharer was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sharer
      @sharer = Sharer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sharer_params
      params.fetch(:sharer, {})
      params.require(:sharer).permit(:service, :size, :sharer, :account_id, :account_password, :user_id, :status)
    end
end
