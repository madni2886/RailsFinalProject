class ApplicationController < ActionController::Base
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?

  protected



end
