class LocationsController < ApplicationController
  before_filter :set_graetzl
  before_filter :authenticate_user!
  before_filter :authorize_user!

  # GET /new/address
  def new_address
  end

  # POST /new/address
  def set_new_address
    address = Address.new(Address.attributes_from_feature(address_params[:feature] || ''))
    session[:address] = address.attributes
    @graetzl = address.graetzl || @graetzl
    @locations = address.locations.
      where(state: [Location.states[:basic], Location.states[:managed]])

    if @locations.empty?
      redirect_to new_graetzl_location_path(@graetzl)
    else
      render :adopt
    end
  end

  def new
    @location = @graetzl.locations.build(address_attributes: session[:address] || Address.new.attributes)
    @location.build_contact    
  end

  def create
    empty_session
    @location = @graetzl.locations.build(location_params)
    if @location.pending!
      flash[:notice] = 'Deine Locationanfrage wird geprüft. Du erhältst eine Nachricht sobald sie bereit ist.'
      redirect_to @graetzl
    else
      render :new
    end 
  end

  def edit
    @location = @graetzl.locations.find(params[:id])
    if !@location.may_adopt?
      # open ownership request
      flash[:notice] = 'Deine Anfrage wird geprüft. Du erhältst eine Nachricht sobald sie bereit ist.'
      redirect_to @graetzl
    end
  end

  def update
    @location = @graetzl.locations.find(params[:id])
    @location.attributes = location_params
    if @location.adopt!
      flash[:notice] = 'Deine Locationanfrage wird geprüft. Du erhältst eine Nachricht sobald sie bereit ist.'
      redirect_to @graetzl
    else
      render :edit
    end    
  end

  def show
    @location = @graetzl.locations.find(params[:id])    
  end

  private

    def set_graetzl
      @graetzl = Graetzl.find(params[:graetzl_id])
    end

    def authorize_user!      
      if !current_user.business?
        flash[:error] = 'Nur wirtschaftstreibende User können Locations betreiben.'
        redirect_to @graetzl
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.
        require(:location).
        permit(:name,
          :slogan,
          :description,
          :avatar, :remove_avatar,
          :cover_photo, :remove_cover_photo,
          contact_attributes: [
            :website,
            :email,
            :phone],
          address_attributes: [
            :street_name,
            :street_number,
            :zip,
            :city,
            :coordinates]).
        merge(user_ids: [current_user.id])
    end

    # strong params for address
    def address_params
      params.permit(:address, :feature)
    end

    def empty_session
      session.delete(:address)
    end
end
