module AddressUtilities
  extend ActiveSupport::Concern

  included do
    before_action :ensure_address, only: [:new]
  end

  def get_address(callback)
    if params[:address]
      address = Address.new(Address.attributes_from_feature(address_params[:feature] || ''))
      puts 'SETTING ADDRESS'
      session[:address] = address.attributes
      callback.call(address)
    else
      session[:address] || Address.new.attributes
    end
  end

  def empty_session
    puts 'EMPTY SESSION'
    session.delete(:address)
  end

  private

    def ensure_address
      render :address_form unless(session[:address] || params[:address])
    end    

    # strong params for address
    def address_params
      params.permit(:address, :feature)
    end
end