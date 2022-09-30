class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
      flash[:notice] ="User not found"
      redirect_back(fallback_location: root_path)

  end

  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  # protect_from_forgery with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?

  protected



end

