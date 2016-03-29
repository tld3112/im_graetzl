class ZuckerlsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  include GraetzlChild

  def index
    @zuckerls = @graetzl.zuckerls.
      page(params[:page]).per(15).
      order("RANDOM()")
  end

  def new
    set_location_for_new or return
    @zuckerl = @location.zuckerls.new
  end

  def create
    @location = Location.find(params[:location_id])
    @zuckerl = @location.zuckerls.new zuckerl_params
    if @zuckerl.save
      redirect_to zuckerl_billing_address_path @zuckerl
    else
      render :new
    end
  end

  def edit
    set_location
    set_zuckerl_or_redirect
  end

  def update
    set_location
    set_zuckerl_or_redirect or return
    if @zuckerl.update zuckerl_params
      redirect_to user_zuckerls_path, notice: 'Zuckerl wurde aktualisiert'
    else
      render :edit
    end
  end

  private

  def set_location_for_new
    case
    when params[:location_id].present?
      @location = Location.find(params[:location_id])
    when current_user.locations.approved.count == 1
      @location = current_user.locations.approved.first
    else
      @locations = current_user.locations.approved
      render :new_location and return
    end
  end

  def set_location
    @location = current_user.locations.find params[:location_id]
  end

  def set_zuckerl_or_redirect
    @zuckerl = @location.zuckerls.where(aasm_state: ['pending', 'paid']).find params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to user_zuckerls_path, alert: 'Zuckerl können leider nicht mehr bearbeitet werden wenn sie live sind.' and return
  end

  def zuckerl_params
    params.require(:zuckerl).permit(
      :title,
      :description,
      :image,
      :remove_image,
      :initiative_id,
      :flyer)
  end
end
