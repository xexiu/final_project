class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @user = User.new unless logged_in?
    @entries_all = Entry.all.order(created_at: :desc).limit(100).paginate(page: params[:page],  :per_page => 5)
    @entries_random = Entry.order("RANDOM()").limit(100).paginate(page: params[:page],  :per_page => 5)
  end

  def help
  end

  def contact
  end

  def tos
  end
end
