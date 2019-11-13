class SharersController < ApplicationController
  before_action :set_sharer, only: [:show, :edit, :update, :destroy]

  # GET /sharers
  # GET /sharers.json
  def index
    @sharers = Sharer.all
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

    service = sharer_params["service"]
    plan = sharer_params["size"]

    if service == "Netflix" && plan == "Standard"
      computed_size = 1
    end
    
    if service == "Netflix" && plan == "Premium"
      computed_size = 3
    end

    if service == "Hulu" && plan == "Standard"
      computed_size = 1
    end

    if service == "Hulu" && plan == "Premium"
      computed_size = 2
    end

    if service == "Prime Video"
      computed_size = 2
    end

    @sharer = Sharer.new(sharer_params)
<<<<<<< HEAD
    @sharer.size = computed_size

    respond_to do |format|
      if @sharer.save
          # TODO: Matching algorithm
          joiners = Joiner.where(service: @sharer.service).order(:created_at).first(@sharer.size)
=======
    #sharer should have a pending status
    respond_to do |format|
      if @sharer.save
        puts
        unless Joiner.first.nil?
          joiners = Joiner.where("? != user_id AND ? == service AND status == ?", @sharer.user_id, @sharer.service, "Pending").order(:created_at).first(@sharer.size)
>>>>>>> improve mathcing algoritm constrains
          if joiners.length > 0
            @sharer.size = @sharer.size - joiners.length
            if @sharer.size == 0
              @sharer.status = "Complete"
            end
            @sharer.save
            joiners.each do |j|
              #create the contracts
              @contract = Contract.new(sharer_id:@sharer.id, sharer_uid: @sharer.user_id, joiner_uid: j.user_id, account_id: @sharer.account_id, account_password: @sharer.account_password)
              @contract.save
<<<<<<< HEAD
              puts "MATCHED SHARER #{@sharer.user_id} TO #{j.user_id}"
=======
              j.status = "Complete"
              j.save
>>>>>>> improve mathcing algoritm constrains
            end
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
