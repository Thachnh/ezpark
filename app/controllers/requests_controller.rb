class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
      current = Time.now
      expired = Request.where(["expire_in < ?", current]).select(:meter_id)
      puts expired.inspect

      blk = Meter.where("id IN (?) ", expired).select(:block_id)
      puts blk.inspect

      b = Block.where("id IN (?)", blk)
      puts b.inspect

      b.each do |block|
        c = block.count
        if (c > 0)
          block.count = c - 1
        end
        block.save
        
      end

      Request.delete_all(["meter_id IN (?)", expired])

      ####


      #block = Block.joins(:meters).where(meters: { meter_id: meter_id})
      #puts block.inspect
    
      @requests = Request.where("expire_in < ?", Time.now)
      #@requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    puts request_params.inspect
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @request }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:meter_id, :paytime, :duration, :expire_in, :status)
    end
end
