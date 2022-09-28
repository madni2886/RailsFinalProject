class GroupsController < ApplicationController
  def index
    @group=Group.all
  end
  def new
    @group = current_user.groups.new
  end
  def create
    @group = current_user.groups.create(group_params)
    @join = @group.memberships.build(:user_id => current_user.id,:req=>1)
    respond_to do |format|
      if @group.save||@join.save
        format.html { redirect_to root_path, notice: "Group was successfully created." }

      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  def join

    @group = Group.find(params[:id])
    if @group.group_type == "Public"
    @join = @group.memberships.build(:user_id => current_user.id,:req=>1)

    respond_to do |format|
      if @join.save
        format.html { redirect_to(user_group_path(current_user,@group), :notice => "You have joined this group.") }
        format.xml { head :ok }
      else
        format.html { redirect_to(user_group_path(current_user,@group), :notice => "You have already joined this group") }
        format.xml { render :xml => user_group_path(current_user,@group), :status => :unprocessable_entity }
      end
    end
    else
      @join = @group.memberships.build(:user_id => current_user.id,:req=>0)
      respond_to do |format|
        if @join.save
      format.html { redirect_to(root_path, :notice => "request successfuly send") }
        else
          format.html { redirect_to(user_group_path(current_user,@group), :notice => "You have already joined this group") }
          format.xml { render :xml => user_group_path(current_user,@group), :status => :unprocessable_entity }
        end
      end
    end
  end




  def show_request
    @group = Group.find(params[:id])
    @membership = @group.memberships

  end
  def accept_request

    @user=User.find(params[:user_id])
    @group = Group.find(params[:id])
    @membership=@group.memberships.find_by_user_id(@user.id)
    @membership.req=true
    @membership.save
  end
  def show
    @group= Group.find(params[:id])
    @post=@group.posts.all
  end
  private
  def group_params
      params.require(:group).permit(:title, :group_type)
  end
end
