class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :destroy]
  before_action :signed_in_user
  before_action :correct_user,   only: [:destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)
    @upload.idea_id = params[:idea_id]
    respond_to do |format|
      if @upload.save
        format.html { redirect_to idea_path(@upload.idea_id), notice: 'Upload was successfully created.' }
        format.json { render json: @upload, status: :created, location: idea_path(@upload.idea_id)}
        format.js 
      else 
        format.html { render action: "new" } 
        format.json { render json: @upload.errors, status: :unprocessable_entity }
        format.js
      end 
    end 
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    flash.now[:notice] = "Successfully removed file."
    respond_to do |format|
      format.html { redirect_to @upload.idea  }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    def correct_user
      @upload = current_user.uploads.find_by(id: params[:id])
      redirect_to root_url if @upload.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params[:upload].permit(:uploaded_file)
    end
end
