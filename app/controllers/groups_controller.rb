class GroupsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    flash[:notice] = "User is not admin nor premium"
    redirect_back(fallback_location: root_path)
    before_action :get_group, only: [:show, :edit, :update, :join, :show_request, :accept_request, :generate_url]
  end

  def index
    @groups = Group.order(:id)
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.create(group_params)
    @join  = @group.memberships.build(:user_id => current_user.id, :req => 1)
    respond_to do | format |
      if @group.save || @join.save
        UserMailer.with(user: current_user, group: @group).send_email.deliver_now
        format.html { redirect_to root_path, notice: "Group was successfully created." }

      else format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @group.image.attach(params[:image])

  end

  def update
    if @group.update(group_params)
      flash[:notice] = "Group was successfully updated"
      redirect_to root_path
    else render "edit"
    end

  end

  def join

    if @group.group_type == "Public"
      @join = @group.memberships.build(:user_id => current_user.id, :req => 1)
      respond_to do | format |
        @join.save ? format.html { redirect_to(user_group_path(current_user, @group), :notice => "You have joined this group.") } :
          format.html { redirect_to(user_group_path(current_user, @group), :notice => "You have already joined this group") }
      end
    else @join = @group.memberships.build(:user_id => current_user.id, :req => 0)
    respond_to do | format |
      @join.save ? format.html { redirect_to(root_path, :notice => "request successfuly send") } :
        format.html { redirect_to(user_group_path(current_user, @group), :notice => "You have already joined this group") }
    end
    end

  end

  def show_request
    @membership = @group.memberships

  end

  def accept_request
    @user           = User.find(params[:user_id])
    @membership     = @group.memberships.find_by_user_id(@user.id)
    @membership.req = true

    redirect_back(fallback_location: root_path) if @membership.save

  end

  def show
    @post = @group.posts.all

  end

  private

  def group_params
    params.require(:group).permit(:title, :group_type, :image, pictures: [])

  end

  def get_group
    @group = Group.find(params[:id])

  end

end
