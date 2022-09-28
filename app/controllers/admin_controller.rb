class AdminController < ApplicationController
  def show_users
    @admin=current_user
    @user=User.all
  end
  def change_plan
    binding.pry
    @user=User.find(:id)

  end
end
