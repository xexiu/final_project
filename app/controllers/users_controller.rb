class UsersController < ApplicationController
  layout 'layout_profiles'
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, :admin_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:edit, :update, :destroy]
  attr_accessor :name, :email

  def index
    @users = User.all
    @users = User.where(activated: true).paginate(page: params[:page], :per_page => 10)
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 10)
    @entries_pos = @user.find_up_voted_items
    @entries_neg = @user.find_down_voted_items
    @entries = @user.entries.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
    redirect_to root_url and return unless true
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # @user.send_activation_email
      # flash[:info] = "Please check your email to activate your account."
      # redirect_to root_url
      log_in @user
      flash[:success] = "Welcome #{@user.name}, to VotesMe!"
      # redirect_to @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      flash[:success] = "User successful deleted"
      format.html { redirect_to users_url }
      format.json { head :no_content }
      format.js
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], :per_page => 10)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 5)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
