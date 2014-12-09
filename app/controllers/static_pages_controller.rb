class StaticPagesController < ApplicationController

  def home
    @user = current_user
    @user = User.new unless logged_in?
    @entries_all = Entry.all.order(created_at: :desc).limit(100).paginate(page: params[:page],  :per_page => 10)
    @entries_random = Entry.order("RANDOM()").limit(100).paginate(page: params[:page],  :per_page => 10)
    @entries_most_voted = Entry.all.order("vote_total DESC").limit(100).paginate(page: params[:page],  :per_page => 10)
     @entries_own = @user.entries.order(created_at: :desc).paginate(page: params[:page],  :per_page => 10)
     @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 10)
  end

  def help
  end

  def contact
  end

  def tos
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  # Before filters

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
