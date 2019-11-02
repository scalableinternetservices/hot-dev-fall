class JoinersController < ApplicationController
  before_action :set_joiner, only: [:show, :edit, :update, :destroy]

  # GET /joiners
  # GET /joiners.json
  def index
    @joiners = Joiner.all
  end

  # GET /joiners/1
  # GET /joiners/1.json
  def show
    @joiner = Joiner.find(params[:id])
  end

  # GET /joiners/new
  def new
    @joiner = Joiner.new
  end

  # GET /joiners/1/edit
  def edit
  end

  # POST /joiners
  # POST /joiners.json
  def create
    @joiner = Joiner.new(joiner_params)

    if @joiner.save
      redirect_to @joiner
    else
      render 'new'
    end
  end

  # PATCH/PUT /joiners/1
  # PATCH/PUT /joiners/1.json
  def update
    respond_to do |format|
      if @joiner.update(joiner_params)
        format.html { redirect_to @joiner, notice: 'Joiner was successfully updated.' }
        format.json { render :show, status: :ok, location: @joiner }
      else
        format.html { render :edit }
        format.json { render json: @joiner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /joiners/1
  # DELETE /joiners/1.json
  def destroy
    @joiner.destroy
    respond_to do |format|
      format.html { redirect_to joiners_url, notice: 'Joiner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_joiner
      @joiner = Joiner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def joiner_params
      params.require(:joiner).permit(:sharer)
    end
end
