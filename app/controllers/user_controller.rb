class UserController < ApplicationController
  load_and_authorize_resource
  def change_plan

    @admin=current_user
    @user=User.find(params[:id])

  end
  def update
    @admin=current_user
    @user=User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to showUser_path

    else
      format.xml { render :xml => change_plan_admin_user_path(@admin,user), :status => :unprocessable_entity }
    end
  end
  def show
    @admin=current_user
    @user=User.find(params[:id])
  end
  protected
  def user_params
    params.require(:user).permit(:username, :plan)
  end
end
