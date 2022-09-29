class AdminController < ApplicationController
  def show_users
    @admin=current_user
    @users=User.all
  end

end
