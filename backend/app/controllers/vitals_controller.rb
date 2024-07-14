class VitalsController < ApplicationController
  before_action :set_vital, only: %i[ show edit update destroy ]

  # GET /vitals or /vitals.json
  def index
    @vitals = Vital.all
  end

  # GET /vitals/1 or /vitals/1.json
  def show
  end

  # GET /vitals/new
  def new
    @vital = Vital.new
  end

  # GET /vitals/1/edit
  def edit
  end

  # POST /vitals or /vitals.json
  def create
    @vital = Vital.new(vital_params)

    respond_to do |format|
      if @vital.save
        format.html { redirect_to vital_url(@vital), notice: "Vital was successfully created." }
        format.json { render :show, status: :created, location: @vital }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vitals/1 or /vitals/1.json
  def update
    respond_to do |format|
      if @vital.update(vital_params)
        format.html { redirect_to vital_url(@vital), notice: "Vital was successfully updated." }
        format.json { render :show, status: :ok, location: @vital }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vitals/1 or /vitals/1.json
  def destroy
    @vital.destroy!

    respond_to do |format|
      format.html { redirect_to vitals_url, notice: "Vital was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vital
      @vital = Vital.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vital_params
      params.require(:vital).permit(:weight, :name)
    end
end
