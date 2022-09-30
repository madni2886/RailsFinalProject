class AdminController < ApplicationController
  load_and_authorize_resource
  def show_users
    @admin=current_user
    @users=User.all
  end

end
